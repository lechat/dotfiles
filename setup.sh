#!/bin/bash

set -o nounset
set -0 pipefail
set -0 errexit

function save_to_old() {
    local item=$1
    if [ -e ~/$item ]; then
        mv ~/$item ~/$item.old
    fi
}

function do_clone() {
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
#    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
}

function make_links() {
    ln -s ~/dotfiles/.vimrc ~/.vimrc
    ln -s ~/dotfiles/.vim ~/.vim
    ln -s ~/dotfiles/.zshrc ~/.zshrc
    ln -s ~/dotfiles/.autoenv ~/.autoenv
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/.xinitrc ~/.xinitrc
    ln -s ~/dotfiles/.Xmodmap ~/.Xmodmap
    ln -s ~/dotfiles/.gitconfig ~/.gitconfig

    if [ ! -e ~/dotfiles/.oh-my-zsh/custom ]; then
        mkdir ~/dotfiles/.oh-my-zsh/custom
    fi
    ln -s ~/dotfiles/.oh-my-zsh/custom ~/.oh-my-zsh/custom
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

