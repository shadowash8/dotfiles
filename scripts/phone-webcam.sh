#!/usr/bin/env bash
# phone-webcam.sh — stream your Android camera as a virtual V4L2 webcam
# Dependencies: v4l2loopback, adb, scrcpy, fzf

set -euo pipefail

# ── colours ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}[•]${RESET} $*"; }
success() { echo -e "${GREEN}[✓]${RESET} $*"; }
warn()    { echo -e "${YELLOW}[!]${RESET} $*"; }
die()     { echo -e "${RED}[✗]${RESET} $*" >&2; exit 1; }

# ── dependency check ───────────────────────────────────────────────────────────
for cmd in adb scrcpy fzf modprobe; do
  command -v "$cmd" &>/dev/null || die "Missing dependency: $cmd"
done

# ── defaults ───────────────────────────────────────────────────────────────────
V4L2_DEVICE="${V4L2_DEVICE:-/dev/video2}"
CARD_LABEL="${CARD_LABEL:-PhoneWebcam}"
CAMERA_ID="${CAMERA_ID:-2}"
BIT_RATE="${BIT_RATE:-7M}"
MAX_FPS="${MAX_FPS:-30}"

# ── resolution menu (fzf) ──────────────────────────────────────────────────────
RESOLUTIONS=(
  "640×480"
  "1280×720"
  "1920×1080"
  "1440×1080"
  "2560×1440"
)

pick_resolution() {
  printf '%s\n' "${RESOLUTIONS[@]}" \
    | fzf --prompt="  Camera resolution > " \
          --header="Use ↑↓ to navigate, Enter to select" \
          --height=12 --border --ansi \
          --color="header:italic,prompt:cyan,pointer:green"
}

echo -e "\n${BOLD}📱  Phone Webcam Setup${RESET}\n"

selected=$(pick_resolution) || die "No resolution selected."
SIZE=$(echo "$selected" | grep -oP '[\d]+[x×][\d]+' | sed 's/[×]/x/')
success "Selected resolution: ${BOLD}${SIZE}${RESET}"

# ── 1. load v4l2loopback ───────────────────────────────────────────────────────
info "Loading v4l2loopback kernel module…"
if lsmod | grep -q v4l2loopback; then
  warn "v4l2loopback already loaded — skipping modprobe"
else
  sudo modprobe v4l2loopback \
    exclusive_caps=1 \
    card_label="$CARD_LABEL" \
    video_nr="${V4L2_DEVICE##*video}" \
    || die "Failed to load v4l2loopback. Is the module installed?"
  success "Loaded v4l2loopback → ${V4L2_DEVICE} (\"${CARD_LABEL}\")"
fi

# verify device exists
[[ -e "$V4L2_DEVICE" ]] || die "Device $V4L2_DEVICE not found after modprobe."

# ── 2. ADB device selection ────────────────────────────────────────────────────
info "Scanning for ADB devices…"
adb start-server &>/dev/null

# list devices: lines after the header that are actually connected
mapfile -t RAW_DEVICES < <(adb devices | tail -n +2 | grep -v '^$')

if [[ ${#RAW_DEVICES[@]} -eq 0 ]]; then
  die "No ADB devices found. Connect your phone and enable USB debugging."
fi

# build a menu: show serial + transport type, highlighting TCP/IP entries
DEVICE_MENU=()
for line in "${RAW_DEVICES[@]}"; do
  serial=$(echo "$line" | awk '{print $1}')
  state=$(echo  "$line" | awk '{print $2}')
  [[ "$state" == "device" ]] && tag="✓ online" || tag="⚠ $state"
  DEVICE_MENU+=("$serial   [$tag]")
done

if [[ ${#DEVICE_MENU[@]} -eq 1 ]]; then
  CHOSEN_SERIAL=$(echo "${DEVICE_MENU[0]}" | awk '{print $1}')
  success "Auto-selected device: ${BOLD}${CHOSEN_SERIAL}${RESET}"
else
  selected_dev=$(
    printf '%s\n' "${DEVICE_MENU[@]}" \
      | fzf --prompt="  ADB device > " \
            --header="Multiple devices detected — choose one" \
            --height=10 --border --ansi \
            --color="header:italic,prompt:cyan,pointer:green"
  ) || die "No device selected."
  CHOSEN_SERIAL=$(echo "$selected_dev" | awk '{print $1}')
  success "Selected device: ${BOLD}${CHOSEN_SERIAL}${RESET}"
fi

# ── 3. TCP/IP port handling ────────────────────────────────────────────────────
# If the serial looks like host:port it's already TCP — nothing to do.
# Otherwise offer to switch to TCP/IP (useful for wireless ADB).
if echo "$CHOSEN_SERIAL" | grep -qP '^\d+\.\d+\.\d+\.\d+:\d+$'; then
  info "Device is already connected via TCP/IP."
else
  echo -e "\n${YELLOW}Connect wirelessly via TCP/IP? (saves USB slot)${RESET}"
  read -rp "  Enter port [default: skip]: " TCP_PORT
  if [[ -n "$TCP_PORT" ]]; then
    info "Enabling ADB TCP/IP on port ${TCP_PORT}…"
    adb -s "$CHOSEN_SERIAL" tcpip "$TCP_PORT" &>/dev/null
    sleep 1
    # try to get the device IP from its WiFi interface
    DEVICE_IP=$(adb -s "$CHOSEN_SERIAL" shell ip route 2>/dev/null \
      | grep -oP 'src \K[\d.]+' | head -1)
    if [[ -n "$DEVICE_IP" ]]; then
      info "Connecting to ${DEVICE_IP}:${TCP_PORT}…"
      adb connect "${DEVICE_IP}:${TCP_PORT}" \
        && CHOSEN_SERIAL="${DEVICE_IP}:${TCP_PORT}" \
        && success "Wireless ADB connected: ${CHOSEN_SERIAL}"
    else
      warn "Could not auto-detect device IP. Continuing with USB serial."
    fi
  fi
fi

# ── 4. launch scrcpy ──────────────────────────────────────────────────────────
echo
info "Starting camera stream…"
echo -e "  ${BOLD}Device:${RESET}     ${CHOSEN_SERIAL}"
echo -e "  ${BOLD}V4L2 sink:${RESET}  ${V4L2_DEVICE}"
echo -e "  ${BOLD}Resolution:${RESET} ${SIZE}"
echo -e "  ${BOLD}Bit-rate:${RESET}   ${BIT_RATE}   ${BOLD}Max FPS:${RESET} ${MAX_FPS}"
echo -e "  ${BOLD}Camera ID:${RESET}  ${CAMERA_ID}"
echo
warn "Press Ctrl+C to stop the stream."
echo

RECONNECT_DELAY=3   # seconds between reconnect attempts
MAX_WAIT=60         # seconds to wait for device before giving up

wait_for_device() {
  local serial="$1"
  local waited=0
  warn "Device offline — waiting for it to come back (${MAX_WAIT}s timeout)…"
  while true; do
    state=$(adb -s "$serial" get-state 2>/dev/null || true)
    if [[ "$state" == "device" ]]; then
      echo
      success "Device back online: ${serial}"
      return 0
    fi
    # For TCP/IP: nudge adb to reconnect the socket
    if echo "$serial" | grep -qP '^\d+\.\d+\.\d+\.\d+:\d+$'; then
      adb connect "$serial" &>/dev/null || true
    fi
    sleep "$RECONNECT_DELAY"
    waited=$(( waited + RECONNECT_DELAY ))
    if (( waited >= MAX_WAIT )); then
      echo
      return 1
    fi
    echo -ne "\r${YELLOW}[!]${RESET} Waiting… ${waited}s / ${MAX_WAIT}s   "
  done
}

run_scrcpy() {
  scrcpy \
    --serial="$CHOSEN_SERIAL" \
    --v4l2-sink="$V4L2_DEVICE" \
    --video-source=camera \
    --camera-id="$CAMERA_ID" \
    --camera-size="$SIZE" \
    --no-playback \
    --video-bit-rate="$BIT_RATE" \
    --max-fps="$MAX_FPS"
}

# ── reconnect loop ─────────────────────────────────────────────────────────────
ATTEMPT=1
while true; do
  [[ $ATTEMPT -gt 1 ]] && info "Stream attempt #${ATTEMPT}…"
  run_scrcpy
  EXIT_CODE=$?

  # scrcpy returns 0 on clean Ctrl+C exit
  if [[ $EXIT_CODE -eq 0 ]]; then
    success "Stream ended cleanly."
    break
  fi

  echo
  warn "scrcpy exited with code ${EXIT_CODE}."

  if ! wait_for_device "$CHOSEN_SERIAL"; then
    die "Device did not come back within ${MAX_WAIT}s. Giving up."
  fi

  ATTEMPT=$(( ATTEMPT + 1 ))
  info "Reconnecting in ${RECONNECT_DELAY}s…"
  sleep "$RECONNECT_DELAY"
  echo
done
