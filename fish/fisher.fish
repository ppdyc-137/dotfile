#!/usr/bin/fish

if type -q fisher
    echo "fisher is already installed"
else
    curl -sL https://mirror.ghproxy.com/raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end
fisher install pure-fish/pure
