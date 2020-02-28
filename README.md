## Overview
![screenshot](screenshot.jpg)
My Arch Linux configuration files for programs and bspwm. I created for you [installation guide](#Installation-guide) and in the [depencences](#dependencies) section you will find a description of the applications required to run full setup.<br>
If you have any problem you can write to me on telegram [@Cherrry9](https://t.me/Cherrry9).
## Table of Contents
1. [Overview](#Overview)
1. [Installation Guide](#Installation-guide)
1. [Dependencies](#dependencies)
## Installation Guide
#### Install dependencies.
Check the list of [dependencies](#dependencies) and install the necessary programs and fonts.
#### Clone the repo.
```
$ git clone https://github.com/Cherrry9/Dotfiles ~/Dotfiles
```
#### Create user directories like ~/Music and ~/Pictures.
```
$ xdg-user-dirs-update
```
#### Go to dotfiles directory.
```
$ cd ~/Dotfiles
```
#### Pull submodules.
```
$ git submodule update --init --recursive
```
#### Use [stow](https://www.gnu.org/software/stow/) to make symlinks.
```
$ stow -vS --no-folding config
```
or manually copy, make symlink to my dotfiles<br/>
If you see something like that:
```
WARNING! stowing config would cause conflicts:
  * existing target is neither a link nor a directory: .bashrc
  * existing target is neither a link nor a directory: .bash_profile
All operations aborted.
```
Delete or copy/move to another directory this file, and run again `stow`.
#### Install fzf from my repo.
```
$ yes | ~/.fzf/install
```
#### Dmenu
```
$ cd ~/.config/dmenu/dmenu-4.9/
$ sudo make clean install
$ cd ../j4-dmenu-desktop
$ cmake .
$ make
$ sudo make install
```
#### Neovim
Install plugins:
```
$ nvim
```
#### Cron
`sudo systemctl enable cronie && sudo systemctl start cronie`, `crontab -e` and add these lines (replace "<you_user>" with the name of your user):
```
# Syncs repositories and notify if there are updates
0,30 * * * * export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0; /home/<you_user>/.local/bin/cron/checkup
# Notify me with notify-send if my battery is low
*/5 * * * * export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0; /home/<you_user>/.local/bin/cron/cronbat
```

#### Installation complete.
Log out and log in to see the changes.
#### Note
My wallpapers are in [Cherrry9/Wallpapers](https://github.com/Cherrry9/Wallpapers)<br>
I created the telegram theme for my rice - [Dotfiles/config/.local/share/TelegramDesktop](https://github.com/Cherrry9/Dotfiles/tree/master/config/.local/share/TelegramDesktop)<br>
You can see all my keybindings with the description using `super + F2` (`$ show_help`)<br>
To see the custom sudo prompt with the bee, add these lines to `/etc/sudoers`:
```
Defaults  lecture="always"
Defaults  lecture_file="/home/<your_user>/.local/share/sudoers.bee"
```
To view the custom login screen with Arch logo on tty:
```
$ cd /etc/
$ mv issue issue-old
$ ~/.scripts/makeissue
```
If you use Arch add this to you `/etc/pacman.conf` (easter egg):
```
ILoveCandy
```
And update you computer :)
## Dependencies
Package name | Description
:--- | :---
bspwm | is awesome tiling window manager
sxhkd | is simple X hotkey daemon
polybar | is a fast and easy to use status bar
alacritty | is a cross-platform, gpu-accelerated terminal emulator
stow | manage farms of symbolic links (easy storage dotfiles)
xorg-server | is our old, but still working graphical server
xorg-xinit | is a tool to start session X (instead of dm)
xdotool | command-line X11 automation tool
xdo | perform actions on windows
picom | is a compositor for X11
xwallpaper | wallpaper setting utility for X
sxiv | is Simple X Image Viewer
xdg-user-dirs |	is a tool to manage user directories like ~/Music and ~/Pictures
xcape | configures modifier keys to act as other keys when pressed and released on their own
xclip | is a command-line interface to the X11 clipboard
slock | allows you to lock your computer, and quickly unlock with your password.
unclutter | hides an inactive mouse.
dmenu (buil in my repo) | is a dynamic menu for X
tmux | is a terminal multiplexer
neovim | is a amazing modal text editor with many plugins
vifm | is a vim-like file manager
ranger-git | is also a vim-like file manager
dunst | is a lightweight notification-daemons
python-pip | is a tool for managing python 3 packages
[ueberzug] | is an alternative for w3mimgdisplay
zsh | is the best UNIX shell
[zgen] (submodule) | is a Zsh plugin manager
[fzf] (submodule) | is a fuzzy finder
pulseaudio-alsa | is a Pulseaudio output plugin for ALSA
mpd | is a lightweight music player daemon
mpc | is a command-line client for the mpd
ncmpcpp | is a mpd client working in the terminal
neomutt | is a terminal mail clent
abook | is a text based address book program (for neomutt)
firefox | is rather fine browser
qutebrowser | is a keyboard-driven, vim-like browser
arc-gtk-theme | nice gtk theme
ttf-dejavu | is a pretty nice font
ttf-inconsolata | is the monospace font
[ttf-font-awesome] | is a popular icon font
zathura | is minimalistic vim-like document viewer
zathura-djvu | DjVu support for Zathura
zathura-pdf-mupdf | PDF support for zathura
cli-visualizer | is a nice music visualizer working in the terminal
cronie | is a cron implementations

#### One liner for Arch:
```
sudo pacman -S bspwm sxhkd alacritty stow xorg-server xorg-xinit xdo xdotool picom xwallpaper sxiv xdg-user-dirs xcape xclip slock unclutter tmux neovim vifm dunst python-pip zsh fzf pulseaudio-alsa mpd mpc ncmpcpp neomutt abook firefox qutebrowser arc-gtk-theme ttf-dejavu ttf-inconsolata ttf-font-awesome zathura zathura-djvu zathura-pdf-mupdf cronie
```
#### AUR:
```
yay -S polybar ranger-git
```
#### Pip:
```
pip3 install --user pynvim ueberzug
```
[ueberzug]: https://github.com/seebye/ueberzug
[ttf-font-awesome]: https://fontawesome.com/download
[zgen]: https://github.com/tarjoilija/zgen
[fzf]: https://github.com/junegunn/fzf#using-git
