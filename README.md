# Preview
![ice](pix/prev/ice.png)
![sea](pix/prev/sea.png)
# Installation guide
## Install dependencies
Packages from official arch repositories:
```
sudo pacman -S --needed git bspwm sxhkd picom dunst libnotify xdo xdotool xdg-user-dirs sxiv urxvt vifm tmux neomutt abook neovim zathura zathura-pdf-mupdf mpd mpc ncmpcpp alsa-utils pulseaudio pulseaudio-alsa ffmpeg maim
```
Packages from AUR:
```
yay -S --needed polybar ranger-git
```
Python packages:
````
pip install --user pynvim msgpack
````
## Install dotfiles
Download dotfiles
```
$ git clone --bare https://github.com/Cherrry9/dots.git $HOME/.config/dots-git
$ alias dots='git --git-dir=$HOME/.config/dots-git/ --work-tree=$HOME'
$ dots checkout
```
If it will fail and show message like this:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```
Move these files to another directories or force chekout (delete all these files)
```
$ dots checkout -f
```
Create user directories like ~/music and ~/pix
```
$ xdg-user-dirs-update
```
Set the flag `showUntrackedFiles` to `no` for dots git repository
```
$ dots config --local status.showUntrackedFiles no
```
Set `zsh` as default shell
```
$ chsh -s /usr/bin/zsh
```
Install dmenu
```
$ cd ~/.config/dmenu
$ sudo make clean install
```
Remove `LICENSE` and `README.md` from your `$HOME`
```
$ dots update-index --assume-unchanged LICENSE README.md
$ rm -rf LICENSE README.md
```
You can revert this later with `--no-assume-unchanged` flag.
## Finished
That's it, dotfiles are ready! It is recommended to restart your computer. Now you can type `dots up` to update dotfiles or use regular git commands:
```
$ dots status
$ dots pull
$ dots add
$ dots commit
$ dots push
```
