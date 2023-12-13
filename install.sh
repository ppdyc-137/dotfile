#!/bin/bash

info() { echo -e "\033[32m\033[01m$*\033[0m"; }   # 绿色

# Install software
sudo pacman -S --needed base-devel fish python tmux neovim htop nodejs npm bat fd the_silver_searcher

# copy config
info "copy config"
cp -r fish ~/.config/
cp -r tmux ~/.config/
cp -r nvim ~/.config/
cp -r joshuto ~/.config/

# fish
info "change shell to fish"
chsh -s /usr/bin/fish
info "install fisher"
fish fish/fisher.sh

# yay
info "install yay"
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
info "install joshuto"
yay -S joshuto-bin

# tmux
info "install tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
info "Press prefix + I to install plugins"

