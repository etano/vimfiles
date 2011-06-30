#!/bin/bash

git submodule init && git submodule update

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
