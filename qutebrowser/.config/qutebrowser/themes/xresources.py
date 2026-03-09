import subprocess
def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], capture_output=True, check=True, text=True)
    lines = x.stdout.split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

xresources = read_xresources("*")

# --- Statusbar ---
c.colors.statusbar.normal.bg = xresources["*background"]
c.colors.statusbar.command.bg = xresources["*background"]
c.colors.statusbar.command.fg = xresources["*foreground"]
c.colors.statusbar.normal.fg = xresources["*color2"]
c.colors.statusbar.insert.fg = xresources["*background"]
c.colors.statusbar.insert.bg = xresources["*color4"]
c.colors.statusbar.passthrough.fg = xresources["*background"]
c.colors.statusbar.passthrough.bg = xresources["*color6"]
c.colors.statusbar.url.fg = xresources["*foreground"]
c.colors.statusbar.url.error.fg = xresources["*color1"]
c.colors.statusbar.url.hover.fg = xresources["*color6"]
c.colors.statusbar.url.success.http.fg = xresources["*color2"]
c.colors.statusbar.url.success.https.fg = xresources["*color4"]

# --- Tabs ---
c.colors.tabs.bar.bg = xresources["*background"]
c.colors.tabs.even.bg = xresources["*background"]
c.colors.tabs.odd.bg = xresources["*background"]
c.colors.tabs.even.fg = xresources["*foreground"]
c.colors.tabs.odd.fg = xresources["*foreground"] 
c.colors.tabs.selected.even.bg = xresources["*color1"]
c.colors.tabs.selected.odd.bg = xresources["*color1"]
c.colors.tabs.selected.even.fg = xresources["*color6"]
c.colors.tabs.selected.odd.fg = xresources["*color6"]
c.colors.hints.bg = xresources["*background"]
c.colors.hints.fg = xresources["*foreground"]
c.tabs.show = "multiple"

# --- Completion ---
c.colors.completion.odd.bg = xresources["*background"]
c.colors.completion.even.bg = xresources["*background"]
c.colors.completion.fg = xresources["*foreground"]
c.colors.completion.category.bg = xresources["*background"]
c.colors.completion.category.fg = xresources["*color4"]
c.colors.completion.category.border.top = xresources["*background"]
c.colors.completion.category.border.bottom = xresources["*background"]
c.colors.completion.item.selected.bg = xresources["*color8"]
c.colors.completion.item.selected.fg = xresources["*foreground"]
c.colors.completion.item.selected.border.top = xresources["*color8"]
c.colors.completion.item.selected.border.bottom = xresources["*color8"]
c.colors.completion.item.selected.match.fg = xresources["*color6"]
c.colors.completion.match.fg = xresources["*color6"]
c.colors.completion.scrollbar.fg = xresources["*foreground"]
c.colors.completion.scrollbar.bg = xresources["*background"]

# --- Context Menu ---
c.colors.contextmenu.disabled.bg = xresources["*background"]
c.colors.contextmenu.disabled.fg = xresources["*color7"]
c.colors.contextmenu.menu.bg = xresources["*background"]
c.colors.contextmenu.menu.fg = xresources["*foreground"]
c.colors.contextmenu.selected.bg = xresources["*color8"]
c.colors.contextmenu.selected.fg = xresources["*foreground"]

# --- Messages ---
c.colors.messages.info.bg = xresources["*background"]
c.colors.messages.info.fg = xresources["*color6"]
c.colors.messages.error.bg = xresources["*background"]
c.colors.messages.error.fg = xresources["*color1"]
c.colors.messages.warning.fg = xresources["*color3"]
c.colors.messages.warning.bg = xresources["*background"]

# --- Downloads ---
c.colors.downloads.error.bg = xresources["*background"]
c.colors.downloads.error.fg = xresources["*color1"]
c.colors.downloads.bar.bg = xresources["*background"]
c.colors.downloads.start.bg = xresources["*color2"]
c.colors.downloads.start.fg = xresources["*foreground"]
c.colors.downloads.stop.bg = xresources["*color8"]
c.colors.downloads.stop.fg = xresources["*foreground"]

# --- Hints ---
c.colors.hints.bg = xresources["*background"]
c.colors.hints.fg = xresources["*foreground"]
c.hints.border = xresources["*foreground"]

# --- Tooltip ---
c.colors.tooltip.bg = xresources["*background"]
c.colors.tooltip.fg = xresources["*foreground"]

# --- Prompts ---
c.colors.prompts.bg = xresources["*background"]
c.colors.prompts.fg = xresources["*foreground"]
c.colors.prompts.border = xresources["*foreground"]
c.colors.prompts.selected.bg = xresources["*color8"]
c.colors.prompts.selected.fg = xresources["*foreground"]

# --- Webpage ---
c.colors.webpage.bg = xresources["*background"]
