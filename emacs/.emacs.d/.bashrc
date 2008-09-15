# ~/.bashrc: executed by bash(1) for non-login shells.

export PS1='\h:\w\$ '
umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval `dircolors`
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -la'
alias l='ls $LS_OPTIONS -lA'
alias lint='~/php5-sandbox/php5/bin/php -l'

export CVS_RSH=ssh

export PATH=$PATH:~/bin

export HISTSIZE=1000000

export TRUNK=~/www/trunk/sourceforge/www/
export RELEASE=~/www/release/sourceforge/www/

export http_proxy=http://43.194.205.179:8080

export SVNBASE=https://tech.scedev.net/source/scedev_source
export SVNTRUNK=$SVNBASE/trunk

alias e='emacs'
alias sc='screen -r'
