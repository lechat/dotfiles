#!/bin/zsh

#zmodload zsh/zprof
# Disable Ctrl-S
stty -ixon

DISABLE_AUTO_UPDATE=true
zstyle ':omz:update' mode disabled
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

# Customize to your needs...
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/scb/.config/nvm/versions/node/v20.0.0/bin

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
ENABLE_CORRECTION=true
ZSH_TMUX_AUTOSTART=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4,bg=16"

plugins=(git python pip docker vi-mode kubectl tmux fzf terraform zsh-autosuggestions)
FZF_BASE=/usr/share/fzf
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4,bg=16"

plugins=(git python pip docker vi-mode kubectl tmux fzf)

source $ZSH/oh-my-zsh.sh

alias sudp='nocorrect sudo'
alias ls-al='nocorrect ls -al'
alias rsync='noglob rsync'
alias docker='sudo docker $@'
alias nvim='VIMRUNTIME=/usr/local/share/nvim/runtime nvim'
alias pygrep='grep -r --include="*.py"'
alias grep='grep -E --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv} --exclude=tags'

# Customize to your needs...
export PATH=$HOME/.local/bin:$HOME/.krew/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
source $HOME/.aliases.sh

export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=33:ln=01;32:bn=32:se=36"
export PYTHONPATH=.:$HOME/.local/lib/python3.6/site-packages:$PYTHONPATH

# Automatically quote URLs pasted in command line
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

#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=bold,underline"
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

#export VIMRUNTIME=/usr/local/share/vim/vim82

export GOPATH=$HOME/src/go
export GOPROXY=https://artifactory.global.standardchartered.com/artifactory/api/go/go-release
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:/home/scb/.config/nvm/versions/node/v20.0.0/bin
export WORKON_HOME=$HOME/venv
export PROJECT_HOME=$HOME/src
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=$(which vim)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:#121212,hl:#5f87af --color=fg+:#d0d0d0,bg+:#964e8a,hl+:#5fd7ff --color=info:#afaf87,prompt:#964e8a,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
export ADO_TOKEN=$(cat $HOME/ado_token)
export PAT=$ADO_TOKEN
export AZURE_TOKEN=$ADO_TOKEN

eval `dircolors $HOME/dotfiles/.dir_colors/solarized`
#eval "$(direnv hook zsh)"

#[ -e $HOME/src ] && cd $HOME/src

#eval "$(direnv hook zsh)"
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
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export NODE_EXTRA_CA_CERTS=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
#zprof

[ -f ~/.local/bin/virtualenvwrapper.sh ] && source ~/.local/bin/virtualenvwrapper.sh
[ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ] && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
unalias kl
[ -f $HOME/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# The next line updates PATH for the Google Cloud SDK.
[ -f '$HOME/src/gcloud/google-cloud-sdk/path.zsh.inc' ] && source '/home/aleksey/src/gcloud/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
[ -f '$HOME/src/gcloud/google-cloud-sdk/completion.zsh.inc' ] && source '/home/aleksey/src/gcloud/google-cloud-sdk/completion.zsh.inc'

autoload -U +X bashcompinit && bashcompinit
[ -f /usr/bin/terraform ] && complete -o nospace -C /usr/bin/terraform terraform
[ -f /etc/zsh_completion.d/fzf-key-bindings ] && complete -C '/usr/local/bin/aws_completer' aws
# fzf shell keybindings
# Fedora
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
# SUSE
[ -f /etc/zsh_completion.d/fzf-key-bindings ] && source /etc/zsh_completion.d/fzf-key-bindings
# Ubuntu
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f $HOME/.ado_token ] && source $HOME/.ado_token

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#if ! ps -ef | grep -v grep | grep remove-hook; then
#  nohup ~/.local/bin/remove-hook 2>&1 > /dev/null &
#fi
nslookup gateway.zscloud.net > /dev/null || source ~/split_vpn.sh && source ~/office_proxy.sh
complete -C '/usr/local/bin/aws_completer' aws

#export HTTP_PROXY=10.0.2.2:9000
#export HTTPS_PROXY=10.0.2.2:9000
#export NO_PROXY=$NO_PROXY,127.0.0.1,localhost,.localdomain,.scb.net,.standardchartered.com,proxypacservice,.sc.net,.scbdev.com,.scb.cloud,.standardchartered.com,.standardchartered.net,.sc.com,.sc.net,.dev.net,.scb.net,.global.standardchartered.com,.internal.sc.com,.eks.amazonaws.com,.awscloud.dev.net,eks.eu-west-2.amazonaws.com,eks.ap-southeast-1.amazonaws.com,sts01.internal.sc.com
export NO_PROXY=$NO_PROXY,127.0.0.1,localhost,.localdomain,.scb.net,.standardchartered.com,proxypacservice,.sc.net,.scbdev.com,.scb.cloud,.standardchartered.com,.standardchartered.net,.sc.com,.sc.net,.dev.net,.scb.net,.global.standardchartered.com,.internal.sc.com,.awscloud.dev.net,sts01.internal.sc.com
unset no_proxy
export http_proxy=$HTTP_PROXY
export https_proxy=$HTTP_PROXY
