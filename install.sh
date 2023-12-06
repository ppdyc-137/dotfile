#!/bin/bash

# Install software
pacman -S --needed base-devel fish python tmux neovim htop nodejs npm bat fd the_silver_searcher

# copy config
echo "copy config"
cp -r fish ~/.config/
cp -r tmux ~/.config/
cp -r nvim ~/.config/
cp -r joshuto ~/.config/

# fish
echo "change shell to fish"
chsh -s /usr/bin/fish
echo "install fisher"
fish fish/fisher.sh

# yay
echo "install yay"
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
echo "install joshuto"
yay -S joshuto-bin

