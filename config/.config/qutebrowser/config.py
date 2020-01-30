#
#               _       _
#    __ _ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
#   / _` | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
#  | (_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
#   \__, |\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|
#      |_|
#


# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Set custom User Agent
# config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0')

# Enable Javascript
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

# Custom Adblock list file
# c.content.host_blocking.lists.append( str(config.configdir) + "/blockedHosts")

# Custom CSS
# c.content.user_stylesheets = ["css/main.css"]

# Change start/default pages + search engine
# config.set("url.start_pages", "https://start.duckduckgo.com/?kae=d")
# config.set("url.default_page", "https://start.duckduckgo.com/?kae=d")
config.set("url.start_pages", "https://cherrry9.github.io/startpage/")
config.set("url.default_page", "https://cherrry9.github.io/startpage/")
config.set("url.searchengines", {"DEFAULT": "https://start.duckduckgo.com/?q={}&kae=d"})

config.bind("pv", "spawn --userscript ~/.config/qutebrowser/script/view_in_mpv")

# Tab settings
config.set("tabs.padding", {"top": 1, "bottom": 2, "left": 5, "right": 5})
config.set("tabs.indicator.width", 0)
config.set("tabs.favicons.scale", 1.2)

# Disable case sensitivity for searching
config.set("search.ignore_case", "always")

# Confirm exit when downloading files
c.confirm_quit = ["downloads"]

# Fonts
c.fonts.monospace = '"DejaVu Sans Mono"'
c.fonts.completion.category = "10pt DejaVu Sans Mono"
c.fonts.completion.entry = "10pt DejaVu Sans Mono"
c.fonts.tabs = "10pt DejaVu Sans Mono"
c.fonts.statusbar = "10pt DejaVu Sans Mono"
c.fonts.downloads = "10pt DejaVu Sans Mono"
c.fonts.hints = "bold 10pt DejaVu Sans Mono"
c.fonts.debug_console = "10pt DejaVu Sans Mono"

# Color Scheme
black = "#121821"
white = "#c6c8d1"
red = "#e27878"
green = "#b4be82"
yellow = "#e2a478"
blue = "#84a0c6"
magenta = "#a093c7"
cyan = "#89b8c2"

background = black
backgroundAlt = "#162130"
accent = blue

# Set colors from color scheme
c.colors.completion.category.bg = background
c.colors.completion.category.border.bottom = background
c.colors.completion.category.border.top = background
c.colors.completion.category.fg = accent
c.colors.completion.fg = white
c.colors.completion.item.selected.bg = backgroundAlt
c.colors.completion.item.selected.border.bottom = backgroundAlt
c.colors.completion.item.selected.border.top = backgroundAlt
c.colors.completion.item.selected.fg = accent
c.colors.completion.match.fg = white
c.colors.completion.odd.bg = background
c.colors.completion.even.bg = background
c.colors.completion.scrollbar.bg = background
c.colors.completion.scrollbar.fg = accent
c.colors.downloads.bar.bg = background
c.colors.downloads.error.fg = red
c.colors.downloads.start.bg = background
c.colors.downloads.start.fg = white
c.colors.downloads.stop.bg = background
c.colors.downloads.stop.fg = accent
c.colors.hints.bg = yellow
c.colors.hints.fg = background
c.colors.hints.match.fg = yellow
c.colors.keyhint.bg = background
c.colors.keyhint.fg = accent
c.colors.keyhint.suffix.fg = accent
c.colors.messages.error.fg = accent
c.colors.messages.error.bg = background
c.colors.messages.error.border = background
c.colors.messages.info.bg = background
c.colors.messages.info.border = background
c.colors.messages.info.fg = accent
c.colors.messages.warning.bg = red
c.colors.messages.warning.border = red
c.colors.messages.warning.fg = background
c.colors.prompts.bg = background
c.colors.prompts.border = background
c.colors.prompts.fg = white
c.colors.prompts.selected.bg = accent
c.colors.statusbar.caret.bg = accent
c.colors.statusbar.caret.fg = background
c.colors.statusbar.caret.selection.bg = accent
c.colors.statusbar.caret.selection.fg = background
c.colors.statusbar.command.bg = backgroundAlt
c.colors.statusbar.command.fg = accent
c.colors.statusbar.command.private.bg = backgroundAlt
c.colors.statusbar.command.private.fg = accent
c.colors.statusbar.insert.bg = backgroundAlt
c.colors.statusbar.insert.fg = accent
c.colors.statusbar.normal.bg = background
c.colors.statusbar.normal.fg = accent
c.colors.statusbar.passthrough.bg = accent
c.colors.statusbar.passthrough.fg = background
c.colors.statusbar.private.bg = background
c.colors.statusbar.private.fg = accent
c.colors.statusbar.progress.bg = accent
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.fg = background
c.colors.statusbar.url.hover.fg = accent
c.colors.statusbar.url.success.http.fg = accent
c.colors.statusbar.url.success.https.fg = accent
c.colors.statusbar.url.warn.fg = red
c.colors.tabs.bar.bg = background
c.colors.tabs.even.bg = background
c.colors.tabs.even.fg = accent
c.colors.tabs.indicator.error = background
c.colors.tabs.indicator.start = accent
c.colors.tabs.indicator.stop = background
c.colors.tabs.odd.bg = background
c.colors.tabs.odd.fg = accent
c.colors.tabs.selected.even.bg = backgroundAlt
c.colors.tabs.selected.even.fg = accent
c.colors.tabs.selected.odd.bg = backgroundAlt
c.colors.tabs.selected.odd.fg = accent
# c.colors.webpage.bg = background
