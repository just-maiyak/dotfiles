alias open="xdg-open"
alias wttr="curl wttr.in/?format=3"
alias vim="nvim"
alias code="codium"
alias cat="bat"
alias ls="exa"
alias cloc="tokei"
alias du="dust"
alias cd="cdl"
alias mcd="mkcd"
alias j="cd"
alias jk='${ZOXIDE_CMD} "${STRUKTUR_PATH}"'
alias fname="find . -name"
alias fd="fdfind"
alias clip="xclip -sel clip"

# python
alias aepy=". ./venv/bin/activate"
alias gpip="PIP_REQUIRE_VIRTUALENV=false pip"

# Docker aliases
alias d="docker"
alias dc="docker image"
alias dc="docker container"
alias dn="docker network"
alias dv="docker volume"

# git aliases
# alias glr="git log --no-merges --format="%s %h" $(git rev-list --tags --max-count=1)..HEAD"
# alias gaf="git rebase -i ${git merge-base HEAD origin/master} --autosquash --update-refs"

# K8s aliases
alias k="kubectl"
alias kxt="kubectl config use-context"

[ "$TERM" = "xterm-kitty" ] && alias ssh="TERM=\"xterm-256color\" kitty +kitten ssh"
