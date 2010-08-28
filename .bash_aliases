
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias ll='ls -laF'
alias j='jobs -l'

alias td='~/bin/todo.sh'

ff() { find . -name "$@" -print; }
lll() { ls -laF "$@" | less; }
ds() { du -ak "$@" | sort -r -n | less; }
psg() { ps ax | grep "$@" | grep -v grep; }
rmbak() { find . -name \*~ -delete; }
tds() { td ls "$@" | sort; }

mkcd() {
	mkdir -p "$*"
	cd "$*"
}

alias vimq='vim $(hg root)/.hg/patches/series'

