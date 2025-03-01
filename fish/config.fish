if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR nvim
    set -g fish_key_bindings fish_vi_key_bindings

    # FZF
    set -x FZF_DEFAULT_OPTS '--exact'
    set -x FZF_DEFAULT_COMMAND 'fd --type f -H'

    function man
        /usr/bin/man $argv | bat -l man -p
    end

    alias l="ls -al"
    alias la="lazygit"
    alias q="exit"
    alias v="nvim"
    alias top="btm"
    alias cat="bat -p"
    alias n="fastfetch"
    alias ra="yazi"
    alias ask="askgpt"

    zoxide init --cmd cd fish | source

    if test -e ~/.config/fish/platform-specific.fish
        source ~/.config/fish/platform-specific.fish
    end
end
