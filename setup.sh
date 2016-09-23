#!/bin/bash

if [ -e ${HOME}/.vimrc ]; then
  echo "${HOME}/.vimrc exists."
  response="Y"
  case $response in
    [yY][eE][sS]|[yY])
      echo "Moving ${HOME}/.vimrc to ${HOME}/.vimrc.bak"
      mv -f ${HOME}/.vimrc ${HOME}/.vimrc.bak
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
  response="Y"
  case $response in
    [yY][eE][sS]|[yY])
      echo "Moving ${HOME}/.vim to ${HOME}/.vim.bak"
      mv -f ${HOME}/.vim ${HOME}/.vim.bak
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


if [ -e ${HOME}/.vim/ftdetect ]; then
  echo "${HOME}/.vim/ftdetect exists."
  response="Y"
  case $response in
    [yY][eE][sS]|[yY])
      echo "Moving ${HOME}/.vim/ftdetect to ${HOME}/.vim/ftdetect.bak"
      mv -f ${HOME}/.vim/ftdetect ${HOME}/.vim/ftdetect.bak
      ;;
    [nN]|[nN])
      echo "Overwriting existing ${HOME}/.vim"
      rm -rf ${HOME}/.vim/ftdetect
      ;;
    *)
      echo "ERROR: Unrecognized response!"
      exit 1
      ;;
  esac
fi

echo "Creating link from ${HOME}/.vim/ftdetect to ${HOME}/.vim/bundle/ultisnips/ftdetect"
mkdir -p ~/.vim/ftdetect
ln -s ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect

echo "Installing plugins"
vim +PluginInstall +qall

echo "done."
