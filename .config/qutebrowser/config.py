#               _       _
#    __ _ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
#   / _` | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
#  | (_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
#   \__, |\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|
#      |_|

# settings
c.colors.webpage.darkmode.enabled = False
c.url.start_pages = "file:///home/cherrry9/.local/share/startpage/index.html"
c.url.default_page = c.url.start_pages
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}'}
c.search.ignore_case = 'smart'
c.content.cookies.accept = 'all'

# mapping
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('gh', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')

# colorscheme
black = "#161821"
white = "#c6c8d1"
red = "#e27878"
green = "#b4be82"
yellow = "#e2a478"
blue = "#84a0c6"
magenta = "#a093c7"
cyan = "#89b8c2"
alt = "#22262e"
accent = blue

c.colors.completion.category.bg = black
c.colors.completion.category.border.bottom = black
c.colors.completion.category.border.top = black
c.colors.completion.category.fg = accent
c.colors.completion.fg = white
c.colors.completion.item.selected.bg = alt
c.colors.completion.item.selected.match.fg = yellow
c.colors.completion.item.selected.border.bottom = alt
c.colors.completion.item.selected.border.top = alt
c.colors.completion.item.selected.fg = accent
c.colors.completion.match.fg = white
c.colors.completion.odd.bg = black
c.colors.completion.even.bg = black
c.colors.completion.scrollbar.bg = black
c.colors.completion.scrollbar.fg = accent
c.colors.downloads.bar.bg = black
c.colors.downloads.error.fg = red
c.colors.downloads.start.bg = black
c.colors.downloads.start.fg = white
c.colors.downloads.stop.bg = black
c.colors.downloads.stop.fg = accent
c.colors.hints.bg = yellow
c.colors.hints.fg = black
c.colors.hints.match.fg = yellow
c.colors.keyhint.bg = black
c.colors.keyhint.fg = accent
c.colors.keyhint.suffix.fg = accent
c.colors.messages.error.fg = accent
c.colors.messages.error.bg = black
c.colors.messages.error.border = black
c.colors.messages.info.bg = black
c.colors.messages.info.border = black
c.colors.messages.info.fg = accent
c.colors.messages.warning.bg = red
c.colors.messages.warning.border = red
c.colors.messages.warning.fg = black
c.colors.prompts.bg = black
c.colors.prompts.border = black
c.colors.prompts.fg = white
c.colors.prompts.selected.bg = accent
c.colors.statusbar.caret.bg = accent
c.colors.statusbar.caret.fg = black
c.colors.statusbar.caret.selection.bg = accent
c.colors.statusbar.caret.selection.fg = black
c.colors.statusbar.command.bg = alt
c.colors.statusbar.command.fg = accent
c.colors.statusbar.command.private.bg = alt
c.colors.statusbar.command.private.fg = accent
c.colors.statusbar.insert.bg = alt
c.colors.statusbar.insert.fg = accent
c.colors.statusbar.normal.bg = black
c.colors.statusbar.normal.fg = accent
c.colors.statusbar.passthrough.bg = accent
c.colors.statusbar.passthrough.fg = black
c.colors.statusbar.private.bg = black
c.colors.statusbar.private.fg = accent
c.colors.statusbar.progress.bg = accent
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.fg = black
c.colors.statusbar.url.hover.fg = accent
c.colors.statusbar.url.success.http.fg = accent
c.colors.statusbar.url.success.https.fg = accent
c.colors.statusbar.url.warn.fg = red
c.colors.tabs.bar.bg = black
c.colors.tabs.even.bg = black
c.colors.tabs.even.fg = white
c.colors.tabs.indicator.error = black
c.colors.tabs.indicator.start = accent
c.colors.tabs.indicator.stop = black
c.colors.tabs.odd.bg = black
c.colors.tabs.odd.fg = white
c.colors.tabs.selected.even.bg = alt
c.colors.tabs.selected.even.fg = accent
c.colors.tabs.selected.odd.bg = alt
c.colors.tabs.selected.odd.fg = accent
c.colors.webpage.bg = black
