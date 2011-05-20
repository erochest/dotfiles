
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias ll='ls -laF'
alias j='jobs -l'

alias t='~/bin/todo.sh'

ff() { find . -name "$@" -print; }
lll() { ls -laF "$@" | less; }
ds() { du -ak "$@" | sort -r -n | less; }
psg() { ps ax | grep "$@" | grep -v grep; }
rmbak() { find . -name \*~ -delete; }
tds() { t ls "$@" | sort; }

mkcd() {
	mkdir -p "$*"
	cd "$*"
}

alias vimq='vim $(hg root)/.hg/patches/series'

alias mamp='pushd /Applications/MAMP'
alias tomcat='pushd /Applications/Tomcat/Home'
alias solr='pushd /Library/Solr/Home'

projectls() {
	cat <<EOF
mamp   => /Applications/MAMP
tomcat => /Applications/Tomcat/Home
solr   => /Libraries/Solr/Home
EOF
}

alias sds1="ssh sds-deployer@sds1.itc.virginia.edu"
alias sds3="ssh sds-deployer@sds3.itc.virginia.edu"
alias sds4="ssh sds-deployer@sds4.itc.virginia.edu"
alias sds5="ssh sds-deployer@sds5.itc.virginia.edu"
alias sds6="ssh sds-deployer@sds6.itc.virginia.edu"
alias sds7="ssh sds-deployer@sds7.itc.virginia.edu"
alias sds8="ssh sds-deployer@sds8.itc.virginia.edu"

alias blue="ssh blue.unix.virginia.edu"
alias utm="ssh utm.lib.virginia.edu"
alias lat="ssh lat.lib.virginia.edu"
alias lon="ssh lon.lib.virginia.edu"

alias aleph="ssh aleph.lib.virginia.edu"
alias omeka="ssh omekadev.lib.virginia.edu"
alias gisdev="ssh gisdev.lib.virginia.edu"
alias gis2="ssh gis2.lib.virginia.edu"

alias slice="ssh err8n@67.23.31.99 -p 7822"

export ANDROID_SDK_HOME=$HOME/src/android-sdk-mac_x86
alias androidenv="PATH=$PATH:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools"

hostls() {
	cat <<EOF
sds1   => sds-deployer@sds1.itc.virginia.edu
sds3   => sds-deployer@sds3.itc.virginia.edu
sds4   => sds-deployer@sds4.itc.virginia.edu
sds5   => sds-deployer@sds5.itc.virginia.edu
sds6   => sds-deployer@sds6.itc.virginia.edu
sds7   => sds-deployer@sds7.itc.virginia.edu
sds8   => sds-deployer@sds8.itc.virginia.edu

blue   => blue.unix.virginia.edu
utm    => utm.lib.virginia.edu
lat    => lat.lib.virginia.edu
lon    => lon.lib.virginia.edu

aleph  => aleph.lib.virginia.edu
omeka  => omekadev.lib.virginia.edu
gisdev => gisdev.lib.virginia.edu
gis2   => gis2.lib.virginia.edu

slice  => err8n@67.23.31.99
EOF
}

# From http://www.catonmat.net/blog/git-aliases for git and hg.
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

alias ha='hg add'
alias har='hg addremove'
alias hpl='hg pull'
alias hph='hg push'
alias hl='hg log'
alias hdf='hg diff'
alias hm='hg commit -m'
alias hma='hg commit --addremove -m'
alias hcl='hg clone'

# vim: set filetype=sh:
