#!/bin/bash

set -o nounset
set -o pipefail
set -o errexit

# Default behavior: do backup and install fonts
DO_BACKUP=1
DO_FONTS=1
DOTFILES="$HOME/dotfiles"

function parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --no-backup)
                DO_BACKUP=0
                shift
                ;;
            --no-fonts)
                DO_FONTS=0
                shift
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: $0 [--no-backup] [--no-fonts]"
                exit 1
                ;;
        esac
    done
}

function install_fonts() {
    if [ -f "$HOME/.config/fonts_installed" ]; then
        echo "Fonts already installed, skipping."
        return
    fi
    git clone --filter=blob:none https://github.com/ryanoasis/nerd-fonts.git fonts
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    touch "$HOME/.config/fonts_installed"
}

function do_clone() {
    local OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"

    if [ -d "$OH_MY_ZSH_DIR/.git" ]; then
        echo "oh-my-zsh already installed at $OH_MY_ZSH_DIR"
    else
        if [ -d "$OH_MY_ZSH_DIR" ]; then
            echo "Warning: $OH_MY_ZSH_DIR exists but is not a valid Git repo. Removing..."
            rm -rf "$OH_MY_ZSH_DIR"
        fi
        echo "Cloning oh-my-zsh to $OH_MY_ZSH_DIR"
        git clone https://github.com/robbyrussell/oh-my-zsh.git "$OH_MY_ZSH_DIR"
    fi

    local CUSTOM_PATH=${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}
    if [ ! -d "$CUSTOM_PATH/plugins/zsh-autosuggestions" ]; then
        echo "Cloning zsh-autosuggestions to $CUSTOM_PATH/plugins/zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$CUSTOM_PATH/plugins/zsh-autosuggestions"
    else
        echo "zsh-autosuggestions already installed"
    fi
}

function backup_file() {
    local src="$1"      # Source file in $DOTFILES
    local dest="$2"     # Destination in $HOME
    local ts="$3"       # Timestamp for backup directory
    local rel_path="$4" # Relative path for subfolder backups

    if [ $DO_BACKUP -eq 1 ] && [ -e "$dest" ] && [ ! "$(readlink "$dest")" = "$src" ]; then
        echo "Backing up $dest to $HOME/.old_dotfiles.$ts/"
        mkdir -p "$HOME/.old_dotfiles.$ts/$(dirname "$rel_path")"
        mv "$dest" "$HOME/.old_dotfiles.$ts/$rel_path"
    fi
}

function make_links() {
    local TS
    [ $DO_BACKUP -eq 1 ] && TS=$(date +'%Y-%m-%d_%H%M')

    # Symlink files in the root of $DOTFILES to $HOME
    for file in "$DOTFILES"/*; do
        if [ -f "$file" ]; then
            local dest="$HOME/$(basename "$file")"
            backup_file "$file" "$dest" "$TS" "$(basename "$file")"
            ln -sf "$file" "$dest"
            echo "Symlinked $(basename "$file") to $dest"
        fi
    done

    # Symlink files in subfolders, creating directories as needed, excluding .git
    find "$DOTFILES" -mindepth 2 -type f -not -path "$DOTFILES/.git/*" | while read -r src; do
        # Get relative path from $DOTFILES (e.g., ".local/bin/kubectx")
        local rel_path="${src#$DOTFILES/}"
        # Destination path in $HOME (e.g., "$HOME/.local/bin/kubectx")
        local dest="$HOME/$rel_path"
        # Directory to create (e.g., "$HOME/.local/bin")
        local dest_dir="$(dirname "$dest")"

        # Backup if file exists and isn’t already the right symlink
        backup_file "$src" "$dest" "$TS" "$rel_path"

        # Create the directory and symlink
        mkdir -p "$dest_dir"
        ln -sf "$src" "$dest"
        echo "Symlinked $rel_path to $dest"
    done
}

function main() {
    parse_args "$@"
    do_clone
    [ $DO_FONTS -eq 1 ] && install_fonts
    make_links
}

main "$@"
