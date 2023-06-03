if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx EDITOR vim

    # FZF
    set -x FZF_DEFAULT_OPTS '--exact'
    set -x FZF_DEFAULT_COMMAND 'fd --type f -H'

    # Pure prompt
    # set -u pure_show_system_time true
    # set -u pure_enable_git true

    alias l="ls -l"
    alias la="ls -la"

    alias q="exit"
    alias clr="clear"

    alias vi="vim"
    alias df="duf"
    alias cat="bat"
    alias du="gdu"
    alias top="htop"

    alias p="pfetch"
    alias n="neofetch"
    alias cw="cowsay"
    alias ra="joshuto"

end
