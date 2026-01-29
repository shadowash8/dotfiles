palette = {
    "background": "#1a1b26",
    "background_alt": "#15161e",
    "background_selected": "#24283b",
    "background_dim": "#414868",

    "foreground": "#c0caf5",
    "foreground_muted": "#565f89",

    "red": "#f7768e",
    "orange": "#e0af68",
    "yellow": "#e0af68",
    "green": "#9ece6a",
    "blue": "#7aa2f7",
    "magenta": "#bb9af7",
    "cyan": "#7dcfff",
    "teal": "#4fd6be",

    "black": "#0f0f14",
}

c.colors.completion.fg = palette["foreground"]
c.colors.completion.odd.bg = palette["background_alt"]
c.colors.completion.even.bg = palette["background"]
c.colors.completion.category.fg = palette["blue"]
c.colors.completion.category.bg = palette["background_alt"]
c.colors.completion.category.border.top = palette["black"]
c.colors.completion.category.border.bottom = palette["black"]
c.colors.completion.item.selected.fg = palette["cyan"]
c.colors.completion.item.selected.bg = palette["background_selected"]
c.colors.completion.item.selected.border.top = palette["background_selected"]
c.colors.completion.item.selected.border.bottom = palette["background_selected"]
c.colors.completion.item.selected.match.fg = palette["orange"]
c.colors.completion.match.fg = palette["yellow"]
c.colors.completion.scrollbar.fg = palette["foreground"]
c.colors.completion.scrollbar.bg = palette["background"]

c.colors.contextmenu.disabled.bg = palette["background_alt"]
c.colors.contextmenu.disabled.fg = palette["foreground_muted"]
c.colors.contextmenu.menu.bg = palette["background"]
c.colors.contextmenu.menu.fg = palette["foreground"]
c.colors.contextmenu.selected.bg = palette["background_selected"]
c.colors.contextmenu.selected.fg = palette["foreground"]

c.colors.downloads.bar.bg = palette["background"]
c.colors.downloads.start.fg = palette["background"]
c.colors.downloads.start.bg = palette["blue"]
c.colors.downloads.stop.fg = palette["background"]
c.colors.downloads.stop.bg = palette["teal"]
c.colors.downloads.error.fg = palette["red"]

c.colors.hints.fg = palette["background"]
c.colors.hints.bg = palette["yellow"]
c.colors.hints.match.fg = palette["foreground"]

c.colors.keyhint.fg = palette["foreground"]
c.colors.keyhint.suffix.fg = palette["yellow"]
c.colors.keyhint.bg = palette["background"]

c.colors.messages.error.fg = palette["red"]
c.colors.messages.error.bg = palette["background"]
c.colors.messages.error.border = palette["red"]
c.colors.messages.warning.fg = palette["orange"]
c.colors.messages.warning.bg = palette["background"]
c.colors.messages.warning.border = palette["orange"]
c.colors.messages.info.fg = palette["cyan"]
c.colors.messages.info.bg = palette["background"]
c.colors.messages.info.border = palette["cyan"]

c.colors.prompts.fg = palette["foreground"]
c.colors.prompts.border = palette["background"]
c.colors.prompts.bg = palette["background"]
c.colors.prompts.selected.bg = palette["background_selected"]
c.colors.prompts.selected.fg = palette["foreground"]

c.colors.statusbar.normal.fg = palette["green"]
c.colors.statusbar.normal.bg = palette["background"]
c.colors.statusbar.insert.fg = palette["background"]
c.colors.statusbar.insert.bg = palette["blue"]
c.colors.statusbar.passthrough.fg = palette["background"]
c.colors.statusbar.passthrough.bg = palette["teal"]
c.colors.statusbar.private.fg = palette["background"]
c.colors.statusbar.private.bg = palette["background_alt"]
c.colors.statusbar.command.fg = palette["foreground"]
c.colors.statusbar.command.bg = palette["background"]
c.colors.statusbar.command.private.fg = palette["foreground"]
c.colors.statusbar.command.private.bg = palette["background"]
c.colors.statusbar.caret.fg = palette["background"]
c.colors.statusbar.caret.bg = palette["magenta"]
c.colors.statusbar.caret.selection.fg = palette["background"]
c.colors.statusbar.caret.selection.bg = palette["blue"]
c.colors.statusbar.progress.bg = palette["blue"]

c.colors.statusbar.url.fg = palette["foreground"]
c.colors.statusbar.url.error.fg = palette["red"]
c.colors.statusbar.url.hover.fg = palette["cyan"]
c.colors.statusbar.url.success.http.fg = palette["green"]
c.colors.statusbar.url.success.https.fg = palette["blue"]
c.colors.statusbar.url.warn.fg = palette["magenta"]

c.colors.tabs.bar.bg = palette["background"]
c.colors.tabs.indicator.start = palette["blue"]
c.colors.tabs.indicator.stop = palette["teal"]
c.colors.tabs.indicator.error = palette["red"]
c.colors.tabs.odd.fg = palette["foreground"]
c.colors.tabs.odd.bg = palette["background_selected"]
c.colors.tabs.even.fg = palette["foreground"]
c.colors.tabs.even.bg = palette["background_selected"]
c.colors.tabs.pinned.even.bg = palette["background_selected"]
c.colors.tabs.pinned.even.fg = palette["foreground"]
c.colors.tabs.pinned.odd.bg = palette["background_selected"]
c.colors.tabs.pinned.odd.fg = palette["foreground"]
c.colors.tabs.pinned.selected.even.bg = palette["background_dim"]
c.colors.tabs.pinned.selected.even.fg = palette["foreground"]
c.colors.tabs.pinned.selected.odd.bg = palette["background_dim"]
c.colors.tabs.pinned.selected.odd.fg = palette["foreground"]
c.colors.tabs.selected.odd.fg = palette["foreground"]
c.colors.tabs.selected.odd.bg = palette["background_dim"]
c.colors.tabs.selected.even.fg = palette["foreground"]
c.colors.tabs.selected.even.bg = palette["background_dim"]
