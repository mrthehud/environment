# ~/.bash_profile: executed by bash(1) for login shells.

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

alias tunnelpsp='ssh sourceforge@psp-pro.com -R 7337:frodo.playstation.sony.com:443'
alias aprst='sudo /sbin/service httpd restart'
alias memstop='sudo /sbin/service memcached stop'
alias memstart='sudo /sbin/service memcached start'
alias pgrst='sudo /sbin/service postgresql restart'
alias sup='svn up'

alias stech='ssh tech.scedev.net'
alias sps2='ssh ps2.scedev.net'
alias spro='ssh psp.scedev.net'
export VISUAL=vim

if [ -d /tmp/uscreens/S-nmakepeace/ ]; then
#	screen -r
echo '';
fi

export FRODO=https://tech.scedev.net/source/scedev_source
export BRANCH=https://tech.scedev.net/source/scedev_source/branches/wip
export TAG=https://tech.scedev.net/source/scedev_source/tags
export TRUNK=https://tech.scedev.net/source/scedev_source/trunk

export VISUAL=emacs
