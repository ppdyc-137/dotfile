if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR nvim
    set -g fish_key_bindings fish_vi_key_bindings

    # FZF
    set -x FZF_DEFAULT_OPTS '--exact'
    set -x FZF_DEFAULT_COMMAND 'fd --type f -H'

    set -x LESS '-R --use-color -Dd+r$Du+b$'
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

    alias l="ls -l"
    alias la="ls -la"
    alias q="exit"
    alias v="nvim"
    alias vi="nvim"
    alias vim="nvim"
    alias top="htop"
    alias cat="bat -p"
    alias n="neofetch"
    alias ra="yazi"

    zoxide init --cmd cd fish | source

    if test -e ~/.config/fish/platform-specific.fish
        source ~/.config/fish/platform-specific.fish
    end

    if test -z $TMUX && ! fish_is_root_user && test -z $NVIM && test -z $VIM && test "$TERM_PROGRAM" != "vscode"
        tmux new-session
    end

end
