
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias ll='ls -laF'
alias j='jobs -l'

alias aswww='sudo -u www-data'
alias mq='hg -R $(hg root)/.hg/patches'

alias pydoc='python2.5 -m pydoc'
alias pdb='python2.5 -m pdb'
alias pybuild='python2.5 setup.py build'
alias pyinstall='sudo python2.5 setup.py install'
alias pytime='python2.5 -m timeit'

alias t='/home/eric/bin/todo.sh'

ff() { find . -name "$@" -print; }
lll() { ls -laF "$@" | less; }
ds() { du -ak "$@" | sort -r -n | less; }
psg() { ps ax | grep "$@" | grep -v grep; }
rmbak() { find . -name \*~ -delete; }
