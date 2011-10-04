#!/bin/bash

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone http://github.com/lechat/dotfiles.git ~/dotfiles

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.zshrc ~/.zshrc

echo "Don't forget to run :BundleInstall! command in vim

