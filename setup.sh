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

function do_clone() {
    if [ ! -d ~/.vim/bundle/vundle/.git ]; then
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    fi
    if [ ! -d ~/.oh-my-zsh/.git ]; then
    	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
#    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    if [ ! -d ~/dotfiles/.oh-my-zsh/custom ]; then
        mkdir -p ~/dotfiles/.oh-my-zsh/custom/plugins
    fi
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/dotfiles/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}

function make_links() {
    ln -sf ~/dotfiles/.vimrc ~/.vimrc
    ln -sf ~/dotfiles/.vim ~/.vim
    ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.autoenv ~/.autoenv
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/.xinitrc ~/.xinitrc
    ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap
    ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
    ln -sf ~/dotfiles/.dir_colors ~/.dir_colors

    ln -sf ~/dotfiles/.oh-my-zsh/custom ~/.oh-my-zsh/custom
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

