#!/bin/bash

cd ~/vimfiles
git submodule init && git submodule update

if [ -e ~/.vim ]; then
  echo "~/.vim exists."
  read -r -p "Do you want backup existing ~/.vim? (Y/N) " response
  case $response in
    [yY][eE][sS]|[yY]) 
      echo "Moving ~/.vim to ~/.vim_backup."
      mv -f ~/.vim ~/.vim_backup
      ;;
    *)
      echo "Overwriting existing ~/.vim"
      ;;
  esac
fi

echo "Creating link from ~/vimfiles to ~/.vim"
ln -sf ~/vimfiles ~/.vim

if [ -e ~/.vimrc ]; then
  echo "~/.vimrc exists."
  read -r -p "Do you want backup existing ~/.vimrc? (Y/N) " response
  case $response in
    [yY][eE][sS]|[yY]) 
      echo "Moving ~/.vimrc to ~/.vimrc_backup."
      mv -f ~/.vimrc ~/.vimrc_backup
      ;;
    *)
      echo "Overwriting existing ~/.vimrc"
      ;;
  esac
fi

echo "Creating link from ~/.vimrc to ~/.vim/vimrc"
ln -sf ~/.vim/vimrc ~/.vimrc


echo "done."
