#!/bin/zsh

# Disable Ctrl-S
stty -ixon

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# ── zi plugin manager ──
source "$HOME/.zi/bin/zi.zsh"

# fnm — Fast Node Manager
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"

# Completions shipped with dotfiles
fpath+=( "$HOME/.oh-my-zsh/completions" )

# zsh-autosuggestions (auto-cloned by zi)
zi lucid for zsh-users/zsh-autosuggestions

# ZSH cache dir (used by some plugins e.g. kubectl)
export ZSH_CACHE_DIR="${HOME}/.cache/zsh"

# Compile and source scripts to central cache
csource() {
  local src="$1"
  local cache="$ZSH_CACHE_DIR/zwc/${src//\//__}"
  local zwc="$cache.zwc"
  if [[ ! -f "$zwc" || "$src" -nt "$zwc" ]]; then
    mkdir -p "$ZSH_CACHE_DIR/zwc"
    cp "$src" "$cache"
    zcompile "$cache"
  fi
  source "$cache"
}


# Local OMZ plugins (git, vi-mode, python, pip, kubectl)
autoload -Uz compinit && compinit -C
csource "$HOME/.oh-my-zsh/custom/git.plugin.zsh"
csource "$HOME/.oh-my-zsh/plugins/vi-mode.plugin.zsh"
csource "$HOME/.oh-my-zsh/plugins/python.plugin.zsh"
csource "$HOME/.oh-my-zsh/plugins/pip.plugin.zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"
csource "$HOME/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh"

# Custom aliases and functions
csource "$HOME/.aliases.sh"

# Theme (synchronous — must set prompt before first render)
setopt prompt_subst

csource "$HOME/.oh-my-zsh/themes/agnoster.zsh-theme"


# export TERM=xterm-256color
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8fa6ad,bg=black"



# Customize to your needs...
export PATH=$HOME/.local/bin:$HOME/.krew/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=33:ln=01;32:bn=32:se=36"

export PYTHONPATH=.

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

# UP/DOWN arrow: prefix-based history search
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward

chpwd_functions=(${chpwd_functions[@]} "source_config")
# source ~/.autoenv/activate.sh

unsetopt correct_all
# oh-my-zsh already handles compinit with -i (skips compaudit)
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh

#export VIMRUNTIME=/usr/local/share/vim/vim82

export GOPATH=$HOME/src/go
export GOPROXY=https://proxy.golang.org
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export WORKON_HOME=$HOME/venv
export PROJECT_HOME=$HOME/src
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=$(which vim)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:#121212,hl:#5f87af --color=fg+:#d0d0d0,bg+:#964e8a,hl+:#5fd7ff --color=info:#afaf87,prompt:#964e8a,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
[ -f $HOME/gemini_api_key ] && export GEMINI_API_KEY=$(cat $HOME/gemini_api_key)

eval "$(dircolors $HOME/.dir_colors)"
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

[ -f $HOME/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)


autoload -U +X bashcompinit && bashcompinit
[ -f /usr/bin/terraform ] && complete -o nospace -C /usr/bin/terraform terraform

# fzf completions & key bindings (Debian/Ubuntu layout)
if (( $+commands[fzf] )); then
  [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
  [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

[[ -e $HOME/.anthropic_api_key ]] && export ANTHROPIC_API_KEY=$(cat $HOME/.anthropic_api_key)
[ -f $HOME/.gemini_api_key ] && export GEMINI_API_KEY=$(cat $HOME/.gemini_api_key)
[ -f $HOME/.gemini_api_key ] && export GOOGLE_GENERATIVE_AI_API_KEY=$(cat $HOME/.gemini_api_key)
export OPENCODE_EXPERIMENTAL_DISABLE_COPY_ON_SELECT=1

# fnm
FNM_PATH="/home/aleksey/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi
