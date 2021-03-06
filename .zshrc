#!/bin/zsh

#zmodload zsh/zprof
# Disable Ctrl-S
stty -ixon

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# export TERM=xterm-256color
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="robbyrussell"
#export ZSH_THEME="juanghurtado"
#export ZSH_THEME="duellj"
#export ZSH_THEME="xiong-chiamiov-plus"
# export ZSH_THEME="gentoo"
# export ZSH_THEME="blinks"
#
export ZSH_THEME="agnoster"
#export ZSH_THEME="agnoster-aleksey"
#
#export ZSH_THEME="agnoster-simple"
#export ZSH_THEME="af-magic"
#export ZSH_THEME="dracula"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
ZSH_TMUX_AUTOSTART=true
plugins=(git python pip docker vi-mode kubectl tmux)

source $ZSH/oh-my-zsh.sh

alias ls-al='nocorrect ls -al'
alias rsync='noglob rsync'
alias docker='sudo docker $@'
alias proxy='export http_proxy=http://10.65.128.43:8080;export https_proxy=http://10.65.128.43:8080'
alias ukproxy='export http_proxy=http://10.192.116.73:8080;export https_proxy=http://10.192.116.73:8080'
alias unproxy='unset http_proxy;unset https_proxy'
alias nvim='VIMRUNTIME=/usr/local/share/nvim/runtime nvim'
alias pygrep='grep -r --include="*.py"'

# Customize to your needs...
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=33:ln=01;32:bn=32:se=36"

export PYTHONPATH=.

#export JAVA_HOME=/maerskwas/tools/jdk1.6.0_30
# export http_proxy=10.65.128.43:8080
# export ftp_proxy=10.65.128.43:8080
# export https_proxy=10.65.128.43:8080

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema '[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'

zle_highlight=(isearch:bold)

# Use vim cli mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=bold,underline"
function source_config() {
    if [ -r $PWD/.zsh_config ]; then
        print "Sourcing $PWD/.zsh_config"
        source $PWD/.zsh_config
    fi
}
chpwd_functions=(${chpwd_functions[@]} "source_config")
# source ~/.autoenv/activate.sh

unsetopt correct_all
autoload -U compinit; compinit
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#source /maerskwas/tools/python2.7venv/bin/activate

# function jump {
#     project=$1
#     env=$2
#     domain_type=$3
#     host=${4:-$domain_type}
#     ssh -t forge "sudo ssh -i /data/keys/${project}_${env}_key ${domain_type}-${project}@${host}.${env}.${project}.apmoller.net"
# }

export VIMRUNTIME=/usr/local/share/vim/vim82

export GOPATH=$HOME/src/go
export GOPROXY=https://proxy.golang.org
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export WORKON_HOME=$HOME/venv
export PROJECT_HOME=$HOME/src
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=$(which vim)

eval `dircolors $HOME/dotfiles/.dir_colors/solarized`
eval "$(direnv hook zsh)"
# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

[ -e $HOME/src ] && cd $HOME/src

eval "$(direnv hook zsh)"
#zprof
# Invoke GnuPG-Agent the first time we login.
# Does `~/.gpg-agent-info' exist and points to gpg-agent process accepting signals?
if test -f $HOME/.gpg-agent-info && \
    kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info | cut -c 16-`
else
    # No, gpg-agent not available; start gpg-agent
    #eval `gpg-agent --daemon --no-grab $HOME/.gpg-agent-info`
fi
export GPG_TTY=`tty`
export GPG_AGENT_INFO
eval "$(direnv hook zsh)"
#zprof

[ -f ~/.local/bin/virtualenvwrapper.sh ] && source ~/.local/bin/virtualenvwrapper.sh
[ -f $HOME/.travis/travis.sh ] && source /home/aleksey/.travis/travis.sh
[ -f $HOME/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# The next line updates PATH for the Google Cloud SDK.
[ -f '$HOME/src/gcloud/google-cloud-sdk/path.zsh.inc' ] && . '/home/aleksey/src/gcloud/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
[ -f '$HOME/src/gcloud/google-cloud-sdk/completion.zsh.inc' ] && . '/home/aleksey/src/gcloud/google-cloud-sdk/completion.zsh.inc'
