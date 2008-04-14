
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias ll='ls -laF'
alias j='jobs -l'

alias pydoc='python2.4 -m pydoc'
alias pdb='python2.4 -m pdb'
alias pybuild='python2.4 setup.py build'
alias pyinstall='sudo python2.4 setup.py install'
alias timeit='python2.4 -m timeit'

alias t='/home/eric/gtd/todo.sh'

ff() { find . -name "$@" -print; }
lll() { ls -laF "$@" | less; }
ds() { du -adk "$@" | sort -r -n | less; }
psg() { ps ax | grep "$@" | grep -v grep; }
rmbak() { find . -name \*~ -delete; }
