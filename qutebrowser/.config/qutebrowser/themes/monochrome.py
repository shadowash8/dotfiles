# --- Monochrome Palette ---
palette = {
    "background": "#000000",
    "background_alt": "#111111",
    "background_selected": "#333333",
    "background_dim": "#222222",

    "foreground": "#bbbbbb",      # Inactive gray
    "foreground_muted": "#555555",
    "foreground_white": "#ffffff", # Active white

    "white": "#ffffff",
    "gray": "#bbbbbb",
    "dark_gray": "#444444",
    "black": "#000000",
}

# Completion Menu
c.colors.completion.fg = palette["foreground"]
c.colors.completion.odd.bg = palette["background"]
c.colors.completion.even.bg = palette["background_alt"]
c.colors.completion.category.fg = palette["white"]
c.colors.completion.category.bg = palette["background"]
c.colors.completion.category.border.top = palette["black"]
c.colors.completion.category.border.bottom = palette["black"]
c.colors.completion.item.selected.fg = palette["white"]
c.colors.completion.item.selected.bg = palette["background_selected"]
c.colors.completion.item.selected.border.top = palette["background_selected"]
c.colors.completion.item.selected.border.bottom = palette["background_selected"]
c.colors.completion.item.selected.match.fg = palette["white"]
c.colors.completion.match.fg = palette["white"]
c.colors.completion.scrollbar.fg = palette["foreground"]
c.colors.completion.scrollbar.bg = palette["background"]

# Hints (The letters that appear when you press 'f')
c.colors.hints.fg = palette["black"]
c.colors.hints.bg = palette["white"]
c.colors.hints.match.fg = palette["gray"]

# Statusbar
c.colors.statusbar.normal.fg = palette["foreground"]
c.colors.statusbar.normal.bg = palette["background"]
c.colors.statusbar.insert.fg = palette["black"]
c.colors.statusbar.insert.bg = palette["white"]
c.colors.statusbar.command.fg = palette["white"]
c.colors.statusbar.command.bg = palette["background"]
c.colors.statusbar.url.fg = palette["foreground"]
c.colors.statusbar.url.success.http.fg = palette["gray"]
c.colors.statusbar.url.success.https.fg = palette["white"]
c.colors.statusbar.url.hover.fg = palette["white"]

# Tabs
c.colors.tabs.bar.bg = palette["background"]
c.colors.tabs.odd.fg = palette["foreground"]
c.colors.tabs.odd.bg = palette["background"]
c.colors.tabs.even.fg = palette["foreground"]
c.colors.tabs.even.bg = palette["background"]
c.colors.tabs.selected.odd.fg = palette["white"]
c.colors.tabs.selected.odd.bg = palette["background_selected"]
c.colors.tabs.selected.even.fg = palette["white"]
c.colors.tabs.selected.even.bg = palette["background_selected"]

# Messages & Prompts
c.colors.messages.info.bg = palette["background"]
c.colors.messages.info.fg = palette["white"]
c.colors.prompts.bg = palette["background"]
c.colors.prompts.fg = palette["white"]

# Render pages in Dark Mode where possible
config.set("colors.webpage.darkmode.enabled", True)
