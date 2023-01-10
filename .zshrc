if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	sudo
	zsh-syntax-highlighting
	command-not-found
	git-open
	colored-man-pages
	extract
	zsh-autosuggestions
	fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'

alias ra="ranger"
alias q="exit"
alias clr="clear"
alias vim="nvim"
alias n="neofetch"
alias t="trans :zh"
alias df="duf"
alias cat="bat"
alias du="gdu"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

export RANGER_LOAD_DEFAULT_RC=FALSE


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
export FZF_DEFAULT_OPTS='--exact'
export FZF_COMPLETION_TRIGGER='\'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# zoxide
eval "$(zoxide init zsh)"
