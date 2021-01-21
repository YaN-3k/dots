# Installation guide
## Install dependencies
* tmux
* sxiv
* irssi
* vifm
* neovim
* dunst
* mpd / mpc / ncmpcpp
* xdg-user-dirs
## Setup dotfiles
Download dotfiles
```
$ git clone --recurse-submodules --bare https://github.com/cherrry9/dots.git ~/.config/dots-git
$ alias dots='git --git-dir ~/.config/dots-git/ --work-tree ~'
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
Move these files to another directories or force checkout (delete all these files)
```
$ dots checkout -f
```
Set the flag `showUntrackedFiles` to `no` for dots git repository
```
$ dots config --local status.showUntrackedFiles no
```
Install fonts
```
$ fc-cache -fv
```
Create user directories:
```
$ mkdir ~/.local/dl ~/dox ~/music ~/pix ~/vid
$ xdg-user-dirs-update
```
Set `zsh` as default shell
```
$ chsh -s /usr/bin/zsh
```
Remove `LICENSE`, `README.md` and `INSTALL.md` from your `~`
```
$ dots update-index --assume-unchanged LICENSE README.md INSTALL.md
$ rm -rf LICENSE README.md INSTALL.md
```
You can revert this later with `--no-assume-unchanged` flag.
## Build and install suckless programs
Example to install foo program:
```
$ cd ~/.config/foo
$ sudo make install
```
## Finished
That's it, dotfiles are ready! It is recommended to restart your computer. Now you can type `dots up` to update dotfiles or use regular git commands:
```
$ dots status
$ dots pull
$ dots add
$ dots commit
$ dots push
```
