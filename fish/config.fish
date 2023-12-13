if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR nvim

    # FZF
    set -x FZF_DEFAULT_OPTS '--exact'
    set -x FZF_DEFAULT_COMMAND 'fd --type f -H'

    set -x LESS '-R --use-color -Dd+r$Du+b$'
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

    # Pure prompt
    # set -u pure_show_system_time true
    # set -u pure_enable_git true

    alias l="ls -l"
    alias la="ls -la"

    alias q="exit"
    alias clr="clear"

    alias vi="nvim"
    alias vim="nvim"
    alias top="htop"
    alias cat="bat -p"
    # alias df="duf"
    # alias du="gdu"

    alias p="pfetch"
    alias n="neofetch"
    alias cw="cowsay"
    alias ra="joshuto"

    if test -z $TMUX
        tmux new-session
    end

end
