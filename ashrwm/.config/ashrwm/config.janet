# autostart
(defn autostart [cmd]
  (ev/spawn (os/proc-wait (os/spawn cmd :p))))

(autostart ["sh" "-c" "swaybg -i $(cat ~/.cache/ashwal/ashwal)"])
(autostart ["dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=ashrwm"])
(autostart ["/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"])
(autostart ["emacs" "--daemon"])
(autostart ["hypridle"])
(autostart ["dunst"])
(autostart ["kdeconnectd"])
(autostart ["dbus-launch" "waybar"])
(autostart ["wlsunset" "-o" "eDP-1" "-g" "0.8" "-l" "19" "-L" "74"])
(autostart ["wl-paste" "--watch" "cliphist" "store"])
(autostart ["audio-init.sh"])

# colors
(put config :background nil)
(dofile (string (os/getenv "HOME") "/.cache/ashwal/colors-ashrwm.janet") :env (curenv))

# input
(put config :tap-to-click true)
(put config :natural-scroll false)
(put config :dwt true)
(put config :focus-follows-mouse true)

# keybinds
(array/push
  (config :xkb-bindings)
  # App launchers
  [:space {:mod4 true} (action/spawn ["rofi" "-show" "drun"])]
  [:Return {:mod4 true} (action/spawn ["foot"])]
  [:v {:mod4 true} (action/spawn ["sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"])]
  [:b {:mod4 true} (action/spawn ["zen-browser"])]
  [:f {:mod4 true} (action/spawn ["thunar"])]
  [:w {:mod4 true} (action/spawn ["emacsclient" "-c" "-a" "emacs"])]
  [:u {:mod4 true} (action/spawn ["hyprlock"])]
  [:p {:mod4 true} (action/spawn ["sh" "-c" "connect"])]
  [:h {:mod4 true} (action/spawn ["foot" "-e" "rmpc"])]
  [:question {:mod4 true} (action/spawn ["rofi" "-show" "recursivebrowser"])]
  [:comma {:mod4 true} (action/spawn ["sh" "-c" "solemn"])]
  [:comma {:mod4 true :ctrl true} (action/spawn ["sh" "-c" "silly"])]
  [:space {:mod4 true :shift true} (action/spawn ["sh" "-c" "notes"])]
  [:space {:mod4 true :ctrl true} (action/spawn ["sh" "-c" "walmenu"])]

  # Volume / Brightness
  [:XF86AudioRaiseVolume {} (action/spawn ["osd" "volume" "5%+"])]
  [:XF86AudioLowerVolume {} (action/spawn ["osd" "volume" "5%-"])]
  [:XF86AudioMute {} (action/spawn ["osd" "volume" "toggle"])]
  [:XF86MonBrightnessUp {} (action/spawn ["osd" "brightness" "10%+"])]
  [:XF86MonBrightnessDown {} (action/spawn ["osd" "brightness" "10%-"])]

  # Screenshots
  [:Print {} (action/spawn ["sh" "-c" "screenshot clip"])]
  [:Print {:mod4 true} (action/spawn ["sh" "-c" "screenshot"])]
  [:Print {:mod4 true :shift true} (action/spawn ["sh" "-c" "screenshot ocr"])]
  [:Print {:mod4 true :ctrl true} (action/spawn ["sh" "-c" "screenshot window"])]
  [:Print {:mod4 true :mod1 true} (action/spawn ["sh" "-c" "screenshot full"])]
  [:Print {:mod4 true :ctrl true :shift true} (action/spawn ["sh" "-c" "screenshot color"])]

  # Window management
  [:q {:mod4 true} (action/close)]
  [:space {:mod4 true} (action/zoom)]
  [:e {:mod4 true} (action/focus :prev)]
  [:n {:mod4 true} (action/focus :next)]
  [:m {:mod4 true} (action/focus-output)]
  [:i {:mod4 true} (action/focus-output)]
  [:a {:mod4 true} (action/fullscreen)]
  [:z {:mod4 true} (action/swap-main)]
  [:s {:mod4 true} (action/sticky)]
  [:g {:mod4 true} (action/float)]
  [:equal {:mod4 true} (action/main-ratio 0.05)]
  [:minus {:mod4 true} (action/main-ratio -0.05)]
  [:Escape {:mod4 true :mod1 true :shift true :ctrl true} (action/passthrough)]
  [:q {:mod4 true :shift true} (action/exit-session)]
  [:0 {:mod4 true} (action/focus-all-tags)])

(for i 1 10
  (def keysym (keyword i))
  (array/push
    (config :xkb-bindings)
    [keysym {:mod4 true} (action/focus-tag i)]
    [keysym {:mod4 true :shift true} (action/set-tag i)]
    [keysym {:mod4 true :mod1 true :shift true} (action/toggle-tag i)]))

(array/push
  (config :pointer-bindings)
  [:left {:mod4 true} (action/pointer-move)]
  [:right {:mod4 true} (action/pointer-resize)])
