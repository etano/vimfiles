#!/bin/bash

git submodule init && git submodule update

if [ -e ~/.vimrc ]
then
  echo "~/.vimrc exists."
  echo "Do you want backup existing ~/.vimrc? (Y/N)"
  read a
  if [[ $a == "Y" || $a == "y" ]]; then
    echo "Moving ~/.vimrc to ~/.vimrc_backup."
    cp ~/.vimrc ~/.vimrc_backup
  else
    echo "Overwritting existing ~/.vimrc"
  fi
fi

ln -sF ~/.vim/vimrc ~/.vimrc

echo "done."
