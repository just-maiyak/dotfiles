# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Define EDITOR
export EDITOR=nvim

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=8000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -a'
# alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# zoxyde (before bash_functions !)
export ZOXIDE_CMD=cd
eval "$(zoxide init --cmd $ZOXIDE_CMD bash)"

# Custom functions definitions.
# Some useful functions might be declared in .bash_functions

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

# conda tab completion
eval "$(register-python-argcomplete conda)"

export COLORTERM=truecolor

# Start Starship
eval "$(starship init bash)"

# GHCup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview '$HOME/.fzf/bin/fzf-preview.sh {}'
  --preview-window 'right,50%,border-left,wrap'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview '$HOME/.fzf/bin/fzf-preview.sh {}' 
  --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -sel clip)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# fzf-git
source "$HOME/.local/fzf-git.sh/fzf-git.sh"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# rf-pypi index
export PIP_CONFIG_FILE="$HOME/.config/pip.conf"

# cargo
. "$HOME/.cargo/env"

# autojump (j)
# [ -f "/usr/share/autojump/autojump.sh" ] && source "/usr/share/autojump/autojump.sh"

# struktur/kubernetes PATH update
export STRUKTUR_PATH="/home/alone/Projects/struktur/kubernetes"
export PATH="$STRUKTUR_PATH/bin:$PATH"

# golang bin in PATH
export GOPATH="/home/alone/.local/bin/go"
export PATH="$GOPATH/bin:$PATH"

# Coursier/Scala bin in PATH
export PATH="$PATH:/home/alone/.local/share/coursier/bin"

# kubectl setup
source <(kubectl completion bash)
source $STRUKTUR_PATH/bin/alias.sh
complete -F __start_kubectl k

# CUDA setup
export CUDAPATH="/usr/local/cuda-12.3"
export PATH="$CUDAPATH/bin:$PATH"

# # AWS
# export AWS_CONFIG_FILE="${RF_ENV}/aws/config"
# export AWS_CREDENTIAL_FILE="${RF_ENV}/aws/credentials"
# export AWS_PROFILE=rf_preprod
# 
# LDAP / ACCOUNTS
export LDAP_UID=yefimchuk
export AD_BIND_DN="CN=YEFIMCHUK Marc,OU=Utilisateurs,OU=General,OU=MRF,DC=radiofrance,DC=rootad,DC=inetrf"

export HIERADATA_PATH="${HOME}/Projects/struktur/wanda/hieradata"
export WANDA_CREDENTIALS="${HOME}/Projects/struktur/wanda/credentials"
export WANDA_PUPPET_GIT_PATH="${HOME}/Projects/struktur/wanda/puppet"
export KUBECONFIG="${WANDA_CREDENTIALS}/generate-kubeconfig/kubeconfig-${LDAP_UID}"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
export HELM_CONFIG_HOME="${STRUKTUR_PATH}/helm/config"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# flutter
export FLUTTERPATH="/home/alone/.flutter/"
export PATH="$FLUTTERPATH/bin:$PATH"

# Android
export PATH="/home/alone/.androidsdk/cmdline-tools/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
eval "$(pixi completion --shell bash)"
