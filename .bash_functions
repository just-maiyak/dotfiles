#!/usr/bin/bash

pwd_short() {
    set +x
    local pwd=$PWD user home component i prefix
    if [[ $pwd =~ $HOME?(/*) ]]; then
        printf '~'
        pwd=${pwd#"$HOME"}
    else
        while IFS= read -r user; do
            eval "home=~$user"
            if [[ $home =~ @(/home/*|/root|/var/*|/srv/*) && $pwd =~ $home?(/*) ]]; then
                printf '~%s' "$user"
                pwd=${pwd#"$home"}
                break
            fi
        done < <(compgen -u)
    fi
    while [[ $pwd == */* ]]; do
        component=${pwd%%/*}
        i=0
        while
            prefix=${component::++i}
            [[ $prefix =~ +(.) ]]
        do :; done
        printf %s/ "$prefix"
        pwd=${pwd#*/}
    done
    printf '%s\n' "$pwd"
}

cdl() {
    if [[ $1 == "+([^/]):*" ]]; then
        local host=${1%%:*} path=${1#*:} path_escaped prefix rest
        if [[ $path == '~'* ]]; then
            IFS=/ read -r prefix rest <<< "$path"
            path_escaped=$prefix${rest:+/${rest@Q}}
        else
            path_escaped=${path@Q}
        fi
        ssh -qt "$host" "cd $path_escaped && BASH_STARTUP=ls exec -l bash"
    else
        ${ZOXIDE_CMD} "$@" && ls -G
    fi
}

mkcd() {
    mkdir -p "$@" && ${ZOXIDE_CMD} "$@"
}

clipf() {
    cat -p "$@" | xclip -sel clip
}

kla() {
    kubectl logs -l "app=$1"
}

# From https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
