#!/bin/bash

set -o nounset
set -o pipefail
set -o errexit

function save_to_old() {
    local item=$1
    if [ -e ~/$item ]; then
        mv ~/$item ~/$item.old
    fi
}

function install_fonts() {
    # clone
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
}

function do_clone() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    if [ ! -d ~/.oh-my-zsh/.git ]; then
    	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
#    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    if [ ! -d ~/dotfiles/.oh-my-zsh/custom ]; then
        mkdir -p ~/dotfiles/.oh-my-zsh/custom/plugins
    fi
    if [ ! -d ~/dotfiles/.oh-my-zsh/custom/plugins/zsh-autosuggestions/.git ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/dotfiles/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi
    install_fonts
}

function make_links() {
    for dir in ~/.oh-my-zsh/completions ~/.local/bin ~/.local/share/nvim; do
        echo "Creating directory: $dir"
        mkdir -p $dir
    done

    ln -sf ~/dotfiles/.vimrc ~/.vimrc
    ln -sf ~/dotfiles/.vim ~/.vim
    ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.autoenv ~/.autoenv
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/.xinitrc ~/.xinitrc
    ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap
    ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
    ln -sf ~/dotfiles/.dir_colors/solarized ~/.dir_colors

    ln -sf ~/dotfiles/.git_template ~/.git_template

    ln -sf ~/dotfiles/.oh-my-zsh/custom ~/.oh-my-zsh/custom

    ln -sf ~/dotfiles/local/bin/kubectx ~/.local/bin/kubectx
    ln -sf ~/dotfiles/completions/_kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh
    ln -sf ~/dotfiles/local/bin/kubens ~/.local/bin/kubens
    ln -sf ~/dotfiles/completions/_kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh
    ln -sf ~/dotfiles/nvim/init.vim ~/.local/share/nvim/init.vim
}

function main() {
    for item in ".oh-my-zsh .vim .zshrc .vimrc .autoenv"; do
        save_to_old $item
    done

    do_clone
    make_links

    vim -c "PluginInstall" -c "qa"
}

main

