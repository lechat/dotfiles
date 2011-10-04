#!/bin/bash

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.zshrc ~/.zshrc

echo "Don't forget to run :BundleInstall! command in vim

