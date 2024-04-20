# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

set -o vi

source ~/.git-prompt.sh

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

#################
### FUNCTIONS ###
#################

# common functions
cd() { builtin cd "$@" && ls; }     # Always list directory contents upon 'cd'
mcd() { mkdir -p "$1" && cd "$1"; } # mcd:          Makes new Dir and jumps inside

#Search Directory
sd() {
	cd "$(fdfind --type d --hidden --exclude .git --exclude .nvm --exclude node_modules --exclude .vscode --exclude .wine --exclude snap --exclude Code --exclude .git --exclude thorium --exclude .nvm --exclude discord --exclude pgadmin4 --exclude .steam --exclude .npm --exclude node_modules --ignore-file ~/.config/fd/.ignore | fzf)"
	nvim
}

#Search File
sf() {
	fdfind --type f --hidden --exclude .git --exclude .nvm --exclude node_modules --exclude .vscode --exclude .wine --exclude snap --exclude Code --exclude .git --exclude thorium --exclude .nvm --exclude discord --exclude pgadmin4 --exclude .steam --exclude .npm --exclude node_modules --exclude .themes| fzf | xargs nvim
}


if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

###############
### EXPORTS ###
###############

export EDITOR="nvim"
export TERMINAL="kitty"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/nvim.appimage:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export FZF_ALT_C_COMMAND="fdfind -t d --exclude .vscode --exclude .wine --exclude snap --exclude Code --exclude .git --exclude thorium --exclude .nvm --exclude discord --exclude pgadmin4 --exclude .steam --exclude .npm --exclude node_modules --hidden . $HOME"
export FZF_DEFAULT_COMMAND="fdfind . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/lucas/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(starship init bash)"
eval "$(rbenv init -)"
