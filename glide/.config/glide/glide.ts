// --- Keymaps ---
glide.keymaps.set(["normal", "visual"], "q", "tab_close");
glide.keymaps.set("normal", "<C-p>", "tab_pin");
glide.keymaps.set("normal", "<S-h>", "back");
glide.keymaps.set("normal", "<S-n>", "forward");
glide.keymaps.set("normal", "<S-o>", "tab_new");

glide.keymaps.set("normal", "cs", "config_reload");

/**
 * Function to read DankMaterialShell colors and update the theme
 */
async function sync_dms() {
  try {
    const dms_raw = await glide.fs.read(
      "/home/ashwin/.cache/DankMaterialShell/dms-colors.json",
      "utf8",
    );
    const dms = JSON.parse(dms_raw);

    // Helper to grab the dark hex from the dank16 objects
    const dk = (colorObj) => colorObj.dark;
    const m = dms.colors.dark; // Material dark palette shorthand
    const d16 = dms.dank16; // Terminal palette shorthand

    await browser.theme.update({
      colors: {
        // --- Main UI ---
        frame: m.background,
        frame_inactive: m.surface_container_lowest,
        toolbar: m.surface_container,
        bookmark_text: m.on_surface,

        // --- The URL Bar (Toolbar Field) ---
        toolbar_field: m.surface_container_high,
        toolbar_field_text: m.on_surface,
        toolbar_field_border: m.outline_variant,
        toolbar_field_focus: m.surface_container_highest,
        toolbar_field_text_focus: m.primary,

        // --- Tabs ---
        tab_line: dk(d16.color5),
        tab_loading: dk(d16.color4),
        tab_selected: m.surface_container_high,
        tab_background_text: m.on_surface_variant,
        tab_text: m.on_surface,

        // --- Background/New Tab ---
        ntp_background: m.background,
        ntp_text: m.on_background,

        // --- Popups and Sidebars ---
        popup: m.surface_container_high,
        popup_text: m.on_surface,
        popup_border: m.outline_variant,
        sidebar: m.surface_container_low,
        sidebar_text: m.on_surface,
        sidebar_border: m.outline_variant,

        // --- Buttons and Icons ---
        icons: m.primary,
        icons_attention: dk(d16.color1), // Peach/Orange for alerts
        button_background_hover: m.surface_variant,
        button_background_active: m.primary_container,
      },
    });

    console.log("Glide: DankMaterialShell colors synced successfully.");
  } catch (err) {
    console.error("Glide: DankMaterialShell sync failed:", err);
  }
}
/**
 * Run sync when the config is loaded or reloaded
 */
glide.autocmds.create("ConfigLoaded", sync_dms);
