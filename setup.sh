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

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.zshrc ~/.zshrc

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo "Don't forget to run :BundleInstall! command in vim"

