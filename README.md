# preview
![ss](pix/prev/ice.png)
![ss](pix/prev/sea.png)

# installation guide
## Install dependencies
Packages from official arch repositories:
```
sudo pacman -S 
```
Packages from AUR:
```
sudo yay -S
```
## Install dotfiles
Download dotfiles
```
$ git clone --bare https://github.com/Cherrry9/dots $HOME/.config/dots
$ alias dot='git --git-dir=$HOME/.config/dots/ --work-tree=$HOME'
$ dot checkout
```
If it will fail and show message like this:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```
You can backup these files with this simple method:

```
$ mkdir -p .config/config-backup && \
$ biual checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
$ xargs -I{} mv {} .config/config-backup/{}
```
Or just remove them:

```
$ biual checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
$ xargs -I{} rm -rf {}
```
Re-run to check out if you have still problems:

```
$ biual checkout
```
Create user directories like ~/Music and ~/Pictures
```
$ xdg-user-dirs-update
```
Set the flag showUntrackedFiles to no for biual git repository
```
$ dot config --local status.showUntrackedFiles no
```
Set zsh as default shell
```
$ chsh -s /bin/zsh
```
Install dmenu
```
$ cd ~/.config/dmenu
$ sudo make clean install
```
Remove LICENSE and README.md from your $HOME
```
$ dot update-index --assume-unchanged LICENSE README.md
$ rm -rf LICENSE README.md
```
You can revert this later with --no-assume-unchanged flag.

## Finished
That's it, dotfiles are ready! It is recommended to restart your computer. Now you can type dot up to update dotfiles or use regular git commands:

```
$ dot status
$ dot pull
$ dot add
$ dot commit
$ dot push
```
