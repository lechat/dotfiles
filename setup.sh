#!/bin/bash

if [ -e ~/.oh-my-zsh ]
then
    mv ~/.oh-my-zsh ~/.oh-my-zsh.old
fi

if [ -e ~/.vim ]
then
    mv ~/.vim ~/.vim.old
fi

if [ -e ~/.zshrc ]
then
    mv ~/.zshrc ~/.zshrc.old
fi

if [ -e ~/.vimrc ]
then
    mv ~/.vimrc ~/.vimrc.old
fi

if [ -e ~/.autoenv ]
then
    mv ~/.autoenv ~/.autoenv.old
fi

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.autoenv ~/.autoenv
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -s ~/dotfiles/.Xmodmap ~/.Xmodmap

mkdir ~/dotfiles/.oh-my-zsh/custom
ln -s ~/dotfiles/.oh-my-zsh/custom ~/.oh-my-zsh/custom

echo "Don't forget to run :PluginInstall! command in vim"

