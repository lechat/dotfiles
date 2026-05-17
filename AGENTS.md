# AGENTS.md - Dotfiles

## Installation

Run `./setup.sh` to symlink dotfiles to `$HOME`. Supports `--no-backup` and `--no-fonts` flags.

## Key Configs

- `.zshrc` - zsh config using oh-my-zsh with agnoster theme
- `.gitconfig` - git config with GPG signing (key: 73B247E7C736117E)
- `.tmux.conf` - tmux configuration
- `.config/nvim/init.lua` - Neovim Lua configuration
- `.config/nvim/lua/` - Neovim Lua modules
- `kube-tmux/` - Kubernetes context display for tmux status bar

## Important Aliases & Environment

- `nvim` - Uses custom `VIMRUNTIME=/usr/local/share/nvim/runtime`
- `docker` - Wrapped with `sudo`
- `claude` - Points to `/home/aleksey/.claude/local/claude`
- Shell loads secrets from `~/.anthropic_api_key`, `~/.gemini_api_key`, `~/.gpg-agent-info`

## Setup Requirements

- oh-my-zsh is cloned to `~/.oh-my-zsh` during setup
- zsh-autosuggestions plugin installed to `$ZSH_CUSTOM/plugins/`
- Nerd Fonts installed (skippable with `--no-fonts`)
- direnv, fzf, and autojump expected in PATH

## Notes

- Shell is zsh (not bash) - use zsh syntax for any modifications
- GPG_TTY must be set for commit signing to work
- tmux auto-starts unless `ZSH_DISABLE_TMUX` is set
