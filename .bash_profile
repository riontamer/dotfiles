#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && source ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

. /home/rjs/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
