# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=30000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# Combining Lachie Cox's crazy Git branch mojo:
#   http://spiral.smartbomb.com.au/post/31418465
# with
#   http://henrik.nyh.se/2008/12/git-dirty-prompt
# AND Geoff Grosenbach's style:
#   http://pastie.org/325104
# Sweeeeeeeet!
function parse_git_dirty {
    (git status --porcelain | egrep "^ ?M " --quiet) && echo "(*)"
}
function parse_git_ahead {
    #git status | grep "Your branch is ahead" | sed "s/# Your branch is ahead of .* by \([0-9]*\) commit.*/(\+\1)/"
    git status --porcelain --branch | egrep -o " \[(ahead|behind).*\]"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\(.*\)/\1$(parse_git_dirty)$(parse_git_ahead)/"
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(git branch &>/dev/null; if [ $? -eq 0 ]; then export GIT_PROMPT="\[\033[1;32m\]$(parse_git_branch)"; echo $GIT_PROMPT; fi) \[\033[00m\]\d \t\n\[\033[00;33m\]\$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}$PPID \u@\h: \w\a\]$PS1"
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -Alrt'
alias hist="git log --pretty=format:'%Cgreen%h %C(yellow)%an %Cblue%ad %Creset%s %d' --graph --date=short"
#alias glist='for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/heads/ ); do git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat ; done | awk '"'! a["'$0'"]++'"
alias glist='git for-each-ref --sort=-committerdate --format="%(color:green)%(committerdate:relative)%(color:reset) %(color:yellow)%(refname:short)%(color:reset) %(color:bold blue)<%(authorname)>%(color:reset)" refs/heads/ | head -n20'
alias redir="> >(tee /tmp/stdout.log) 2> >(tee /tmp/stderr.log >&2)"

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


export EDITOR=vim

export JDK_HOME=/usr/lib/jvm/default-java
export JAVA_HOME=/usr/lib/jvm/default-java

#export M2_HOME=/usr/share/maven2
export M3_HOME=/usr/share/maven

export SVN_EDITOR=vim

CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -Xmx2048m -XX:MaxPermSize=128m"
if [ -e $HOME/sewichi/aws/aws-setup ]; then
    source $HOME/sewichi/aws/aws-setup
fi

export ANDROID_HOME=/home/nick/downloads/android-sdk
export HADOOP_PREFIX=/home/nick/downloads/hadoop

export PATH=$M3_HOME/bin:$M2_HOME/bin:$PATH:/usr/lib/jvm/default-java/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/home/nick/downloads/mongodb/bin:/home/nick/bin:/home/nick/environment/bin:$HADOOP_PREFIX/bin:/home/nick/downloads/stat/bin
export MAVEN_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -Xmx1024M -XX:MaxPermSize=512M" 
#add these options to get maven debug
# -Xrunjdwp:transport=dt_socket,address=6006,server=y,suspend=n

#if which ruby >/dev/null && which gem >/dev/null; then
#    export PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
#fi

#at Placed we use this environment var to hook into pry/pry_debug for testing
PRY_RESCUE_ENABLED=true

#it's irritating to hit tab and have ssh block for a while before you can type stuff again, so turn that off!
# this doesn't work in ubuntu 14.04
#complete -r ssh scp

#add some neat predefined functions for bc
export BC_ENV_ARGS=~/.bcrc

export HADOOP_PREFIX=/home/nick/downloads/hadoop
export PRY_RESCUE_ENABLED=true

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#add node to path
export PATH="$PATH:$HOME/downloads/node/bin"

#add python pip local bin to path
export PATH="$PATH:$HOME/.local/bin"

export LESS="-FXR"

#I don't know how I feel about this, but I need RVM to use different ruby
# versions
#. ~/.rvm/scripts/rvm

export PLACED_REPO_DIR=/home/nick/sewichi/src

if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

alias ytmnd=fml
