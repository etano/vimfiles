#!/bin/bash

if [ -e ${HOME}/.vimrc ]; then
  echo "${HOME}/.vimrc exists."
  read -r -p "Do you want backup existing ${HOME}/.vimrc? (Y/N) " response
  case $response in
    [yY][eE][sS]|[yY])
      echo "Moving ${HOME}/.vimrc to ${HOME}/.vimrc_backup."
      mv -f ${HOME}/.vimrc ${HOME}/.vimrc_backup
      ;;
    [nN]|[nN])
      echo "Overwriting existing ${HOME}/.vimrc"
      rm ${HOME}/.vimrc
      ;;
    *)
      echo "ERROR: Unrecognized response!"
      exit 1
      ;;
  esac
fi

echo "Creating link from ${HOME}/.vimrc to ${HOME}/.vim/vimrc"
ln -sf ${HOME}/vimfiles/vimrc ${HOME}/.vimrc

if [ -e ${HOME}/.vim ]; then
  echo "${HOME}/.vim exists."
  read -r -p "Do you want backup existing ${HOME}/.vim? (Y/N) " response
  case $response in
    [yY][eE][sS]|[yY])
      echo "Moving ${HOME}/.vim to ${HOME}/.vim_backup."
      mv -f ${HOME}/.vim ${HOME}/.vim_backup
      ;;
    [nN]|[nN])
      echo "Overwriting existing ${HOME}/.vim"
      rm -rf ${HOME}/.vim
      ;;
    *)
      echo "ERROR: Unrecognized response!"
      exit 1
      ;;
  esac
fi

echo "Creating link from ${HOME}/vimfiles to ${HOME}/.vim"
ln -sf ${HOME}/vimfiles ${HOME}/.vim


cd ${HOME}/vimfiles
git submodule init && git submodule update

echo "done."
