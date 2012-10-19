# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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
export ZSH_THEME="gentoo"

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
plugins=(git svn python pip bashcomplete)

source $ZSH/oh-my-zsh.sh

alias ls-al='nocorrect ls -al'
alias grep='grep -n -I'
alias frg='ssh forge.xleap.apmoller.net'

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/home/xleap/bin:/usr/local/sbin:/usr/sbin:/sbin

export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=33:ln=01;32:bn=32:se=36"

export PYTHONPATH=~/src/adlt/deployment/framework/domain_build:~/src/adlt/deployment/framework/app_deploy:~/src/adlt/deployment/framework/domain_build/shared/scripts:~/src/adlt/deployment/framework/domain_build/shared:~/src/adlt/deployment/framework/shared:~/opt/graphite

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema '[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'

zle_highlight=(isearch:bold)

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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
