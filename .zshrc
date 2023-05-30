export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
	git
	sudo
	zsh-syntax-highlighting
	git-open
	colored-man-pages
	extract
	zsh-autosuggestions
	fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'

alias ra="joshuto"
alias q="exit"
alias clr="clear"
alias vim="nvim"
alias vi="nvim"
alias n="neofetch"
alias df="duf"
alias cat="bat"
alias du="gdu"
alias cw="cowsay"
alias top="htop"

# fzf
export FZF_DEFAULT_OPTS='--exact'
export FZF_COMPLETION_TRIGGER='\'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .cache -g ""'

# pure prompt
autoload -U promptinit; promptinit
prompt pure

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
