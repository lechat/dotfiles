# ── Aliases ──

alias tma='tmux new-session -A -s human'
alias tmd='tmux detach-client'

alias sudp='nocorrect sudo'
alias ls-al='nocorrect ls -al'
alias rsync='noglob rsync'
alias docker='sudo docker $@'
alias nvim='VIMRUNTIME=/usr/local/share/nvim/runtime nvim'
alias pygrep='grep -r --include="*.py"'
alias grep='grep -E --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv} --exclude=tags'

alias claude="/home/aleksey/.claude/local/claude"
alias history='fc -l 1'

# ── Functions ──

# Ctrl-R: prefix-based history search via fzf (override fzf-history-widget)
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | awk -v q="${LBUFFER}" '{
    cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd);
    if (!seen[cmd]++ && (length(q) == 0 || index(cmd, q) == 1)) print $0
  }' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS-} -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

# Stub functions for OMZ agnoster theme
parse_git_dirty() {
  command git status --porcelain 2>/dev/null | command grep -q . && echo "±"
}
tf_prompt_info() { :; }

source_config() {
    if [ -r $PWD/.zsh_config ]; then
        print "Sourcing $PWD/.zsh_config"
        source $PWD/.zsh_config
    fi
}

nvm() {
  echo "Use fnm instead: fnm install/use/list/uninstall/..."
}

# ── OMZ lib: directories ──
alias -- -='cd -'
alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -A'
d() { dirs -v | head -10; }
take() { mkdir -p "$1" && cd "$1"; }
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# ── OMZ lib: misc ──
alias _='sudo '

# ── OMZ lib: functions ──
zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++}END{for(a in CMD)print CMD[a]" "CMD[a]*100/count"% "a}' \
    | grep -v "./" | sort -nr | head -20 | column -c3 -s " " -t | nl
}
