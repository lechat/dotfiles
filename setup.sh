#!/bin/bash

set -o nounset
set -o pipefail
set -o errexit

function save_to_old() {
  local TS=$(date +'%Y-%m-%d_%H%M')
  for item in .zshrc .vimrc .autoenv .tmux.conf .xinitrc .gitconfig .Xmodmap .dir_colors .git_template; do
    if [ -e $HOME/$item ] && [ -L $HOME/$item ]; then
      echo "Skipping saving a link of $item"
    else
      if [ -e $HOME/$item ]; then
        echo "Moving $item to $HOME/.old_dotfiles.$TS/"
        mkdir -p $HOME/.old_dotfiles.$TS
        mv $HOME/$item $HOME/.old_dotfiles.$TS/
      else
        echo "Skipping non-existent file $HOME/$item"
      fi
    fi
  done
}

function install_fonts() {
    # The marker file is left once fonts are installed
    if [ -f $HOME/.config/fonts_installed ]; then
        return
    fi
    # clone
    git clone --filter=blob:none https://github.com/ryanoasis/nerd-fonts.git fonts
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
    touch $HOME/.config/fonts_installed
}

function install_coc() {
    # Install latest nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
        nvm install node
    fi
    # Use package feature to install coc.nvim

    # for vim8
    # mkdir -p $HOME/.vim/pack/coc/start
    # cd $HOME/.vim/pack/coc/start
    # curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
    # for neovim
    # mkdir -p $HOME/.local/share/nvim/site/pack/coc/start
    # cd $HOME/.local/share/nvim/site/pack/coc/start
    # curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

    # Install extensions
    if [ ! -d $HOME/.config/coc/extensions ]; then
        mkdir -p $HOME/.config/coc/extensions
        cd $HOME/.config/coc/extensions
        if [ ! -f package.json ]
        then
          echo '{"dependencies":{}}'> package.json
        fi
        # Change extension names to the extensions you need
        npm install coc-css coc-docker coc-go coc-html coc-html-css-support coc-pyright coc-json coc-copilot coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
    fi
}

function do_clone() {
    if [ ! -d $HOME/.vim/bundle/Vundle.Vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.Vim
    else
        echo "Vundle already installed"
    fi

    if [ ! -d $HOME/.oh-my-zsh/.git ]; then
    	git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
    else
        echo "oh-my-zsh already installed"
    fi

    local CUSTOM_PATH=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
    if [ ! -d $CUSTOM_PATH ]; then
        mkdir -p $HOME/dotfiles/.oh-my-zsh/custom/plugins
    fi

    if [ ! -d $CUSTOM_PATH/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $CUSTOM_PATH/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions already installed"
    fi
}

function make_links() {
    for dir in $HOME/.oh-my-zsh/completions $HOME/.local/bin $HOME/.local/share/nvim $HOME/.config/nvim/lua; do
        echo "Creating directory: $dir"
        mkdir -p $dir
    done

    ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
    ln -sf $HOME/dotfiles/.vim $HOME/.vim
    ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc

    ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
    ln -sf $HOME/dotfiles/.xinitrc $HOME/.xinitrc
    ln -sf $HOME/dotfiles/.Xmodmap $HOME/.Xmodmap
    ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
    ln -sf $HOME/dotfiles/.dir_colors/solarized $HOME/.dir_colors

    if [ -e $HOME/.autoenv ] && [ -L $HOME/.autoenv ]; then
        unlink $HOME/.autoenv
    fi
    ln -sf $HOME/dotfiles/.autoenv $HOME/.autoenv

    if [ -e $HOME/.git_template ] && [ -L $HOME/.git_template ]; then
        unlink $HOME/.git_template
    fi
    ln -sf $HOME/dotfiles/.git_template $HOME/.git_template

    ln -sf $HOME/dotfiles/local/bin/kubectx $HOME/.local/bin/kubectx
    ln -sf $HOME/dotfiles/completions/_kubectx.zsh $HOME/.oh-my-zsh/completions/_kubectx.zsh
    ln -sf $HOME/dotfiles/local/bin/kubens $HOME/.local/bin/kubens
    ln -sf $HOME/dotfiles/completions/_kubens.zsh $HOME/.oh-my-zsh/completions/_kubens.zsh
    ln -sf $HOME/dotfiles/nvim/init.lua $HOME/.local/share/nvim/init.lua
    ln -sf $HOME/dotfiles/nvim/init.lua $HOME/.config/nvim/init.lua
    ln -sf $HOME/dotfiles/nvim/lua/coc.lua $HOME/.config/nvim/lua/coc.lua
}

function main() {
    save_to_old
    do_clone
    install_fonts
    make_links
    install_coc
    vim +PluginInstall +qall
}

main

