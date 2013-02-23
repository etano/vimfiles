#!/bin/bash

cd ${HOME}/vimfiles
git submodule init && git submodule update

if [ -e ${HOME}/.vim ]; then
  echo "${HOME}/.vim exists."
  read -r -p "Do you want backup existing ${HOME}/.vim? (Y/N) " response
  case $response in
    [yY][eE][sS]|[yY]) 
      echo "Moving ${HOME}/.vim to ${HOME}/.vim_backup."
      mv -f ${HOME}/.vim ${HOME}/.vim_backup
      ;;
    *)
      echo "Overwriting existing ${HOME}/.vim"
      ;;
  esac
fi

echo "Creating link from ${HOME}/vimfiles to ${HOME}/.vim"
ln -sf ${HOME}/vimfiles ${HOME}/.vim

if [ -e ${HOME}/.vimrc ]; then
  echo "${HOME}/.vimrc exists."
  read -r -p "Do you want backup existing ${HOME}/.vimrc? (Y/N) " response
  case $response in
    [yY][eE][sS]|[yY]) 
      echo "Moving ${HOME}/.vimrc to ${HOME}/.vimrc_backup."
      mv -f ${HOME}/.vimrc ${HOME}/.vimrc_backup
      ;;
    *)
      echo "Overwriting existing ${HOME}/.vimrc"
      ;;
  esac
fi

echo "Creating link from ${HOME}/.vimrc to ${HOME}/.vim/vimrc"
ln -sf ${HOME}/.vim/vimrc ${HOME}/.vimrc


echo "done."
