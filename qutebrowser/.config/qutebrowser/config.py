# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
import os
import subprocess
# pylint settings included to disable linting errors

# tabs
c.tabs.show = "multiple"
c.tabs.title.format = "{audio}{current_title}"

# url
c.url.default_page = "https://shadowash8.github.io/minimal-startpage/"
c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }
c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

# keybinding changes
config.bind('<alt-x>', 'cmd-set-text :')
config.bind('=', 'cmd-set-text -s :open')
config.bind('h', 'history')
config.bind('q', 'tab-close')
config.bind('N', 'forward')
config.bind('B', 'back')
config.bind('cc', 'hint images spawn sh -c "cliphist link {hint-url}"')
config.bind('cs', 'cmd-set-text -s :config-source')
config.bind('tH', 'config-cycle tabs.show multiple never')
config.bind('sH', 'config-cycle statusbar.show always never')
config.bind('T', 'hint links tab')
config.bind('pP', 'open -- {primary}')
config.bind('pp', 'open -- {clipboard}')
config.bind('pt', 'open -t -- {clipboard}')
config.bind('qm', 'macro-record')
config.bind('<ctrl-y>', 'spawn mpv {url}')
config.bind('tT', 'config-cycle tabs.position top left')
config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('gm', 'tab-move')

# dark mode setup
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'smart'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# styles, cosmetics
colors_path = os.path.expanduser('~/.config/colors/qutebrowser.py')
config.source(colors_path)
# Check which TWM is running
#def get_current_wm():
#    # Check if we are on Wayland (Hyprland)
#    if os.environ.get('WAYLAND_DISPLAY'):
#        return "hyprland"
#    # Check X11 Desktop variable
#    desktop = os.environ.get('XDG_CURRENT_DESKTOP', '').lower()
#    if 'dwm' in desktop:
#        return "dwm"
#    return "unknown"
#
#wm = get_current_wm()
#
## Apply themes based on the detected WM
#if wm == "hyprland":
#    if os.path.exists(colors_path):
#        config.source(colors_path)
#else:
#    # Default to your sick Monochrome setup for DWM
#    config.source("./themes/monochrome.py")

c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.scrolling.smooth = True

# fonts
c.fonts.default_family = 'Iosevka'
c.fonts.default_size = '11pt'
c.fonts.web.size.default = 16
c.fonts.web.family.fixed = 'Iosevka'
c.fonts.web.family.sans_serif = 'Iosevka'
c.fonts.web.family.serif = 'Iosevka'
c.fonts.web.family.standard = 'Iosevka'
# hints
c.hints.chars = 'arstneio'

# misc
config.load_autoconfig() 
c.auto_save.session = True 
c.content.pdfjs = True
c.editor.command =["nvim", "-f", "{file}", "-c", "normal {line}G{column0}l"]

# privacy - adjust these settings based on your preference
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)
config.set("content.headers.user_agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.3")
# config.set("content.javascript.enabled", False) # tsh keybind to toggle

# Adblocking
c.content.blocking.enabled = True
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-general.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-mobile.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/experimental.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/ubo-link-shorteners.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/ubol-filters.txt"]
