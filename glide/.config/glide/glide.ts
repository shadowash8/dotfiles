// --- Keymaps ---
glide.keymaps.set(["normal", "visual"], "q", "tab_close")
glide.keymaps.set("normal", "<C-p>", "tab_pin")
glide.keymaps.set("normal", "<S-h>", "back")
glide.keymaps.set("normal", "<S-n>", "forward")
glide.keymaps.set("normal", "<S-o>", "tab_new")

glide.keymaps.set("normal", "cs", "config_reload");

/**
 * Function to read Pywal colors and update the theme
 */
async function sync_pywal() {
    try {
        // Glide's internal FS API can read local files without CORS issues
        const wal_raw = await glide.fs.read("/home/ashwin/.cache/cwal/colors.json", "utf8");
        const wal = JSON.parse(wal_raw);

        await browser.theme.update({
            colors: {
                // Main UI
                frame: wal.special.background,
                toolbar: wal.special.background,

                // The URL Bar
                toolbar_field: wal.special.background,
                toolbar_field_text: wal.special.foreground,
                toolbar_field_border: wal.colors.color8,

                // Tabs and Misc
                tab_line: wal.colors.color1,
                tab_background_text: wal.colors.color7,
                popup: wal.special.background,
                popup_text: wal.special.foreground,

                // New Tab Page
                ntp_background: wal.special.background,
                ntp_text: wal.special.foreground,
            },
        });
        console.log("Glide: Pywal colors synced successfully.");
    } catch (err) {
        console.error("Glide: Pywal sync failed:", err);
    }
}

/**
 * Run sync when the config is loaded or reloaded
 */
glide.autocmds.create("ConfigLoaded", sync_pywal);

