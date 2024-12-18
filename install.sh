#!/bin/bash
set -e

info() { echo -e "\033[32m\033[01m$*\033[0m"; }   # green
error() { echo -e "\033[31m\033[01m$*\033[0m"; }   # red

install_config() {
    target=$PWD/$1
    link_name=$HOME/.config/$1

    info "ln $link_name -> $target"
    if [ ! -d $target ]; then
        error "$target does not exists!"
        return
    fi
    if [ -d $link_name ]; then
        error "$link_name already exists!"
        return
    fi

    ln -s $PWD/$1 $HOME/.config/$1
}

# Install software
sudo pacman -S --needed base-devel fish python tmux neovim htop nodejs npm bat fd ripgrep zoxide yazi tree-sitter

# install config
CONFIGS=("fish" "nvim" "yazi")
for config in "${CONFIGS[@]}"; do
    install_config $config
done

# yay
info "Install yay"
if command -v yay >/dev/null 2>&1; then
    echo "yay is already installed"
else
    git clone https://aur.archlinux.org/yay.git && makepkg -D yay -si && rm -rf yay
fi

# fish
info "Install fisher"
fish fish/fisher.fish

# tmux
# info "Install tpm"
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# info "Press prefix + I to install plugins"
