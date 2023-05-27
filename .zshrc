export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
	git
	sudo
	zsh-syntax-highlighting
	colored-man-pages
	extract
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration
alias ra="joshuto"
alias q="exit"
alias clr="clear"
alias vi="vim"
alias n="neofetch"
alias df="duf"
alias cat="bat"
alias top="htop"

# fzf
export FZF_DEFAULT_OPTS='--exact'
export FZF_COMPLETION_TRIGGER='\'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .cache -g ""'

# pure prompt
autoload -U promptinit; promptinit
prompt pure
