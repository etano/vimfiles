#!/bin/bash

git submodule init && git submodule update

echo "Creating link from ${HOME}/.vimrc to ${PWD}/vimrc"
if [ -e ${HOME}/.vimrc ]; then rm ${HOME}/.vimrc; fi
ln -sf ${PWD}/vimrc ${HOME}/.vimrc

echo "Creating link from ${HOME}/.vim to ${PWD}"
if [ -e ${HOME}/.vim ]; then
  if [ -L ${HOME}/.vim ]; then rm ${HOME}/.vim; else rm -rf ${HOME}/.vim; fi
fi
ln -sf ${PWD} ${HOME}/.vim

echo "Creating link from ${HOME}/.vim/ftdetect to ${HOME}/.vim/bundle/ultisnips/ftdetect"
if [ -e ${HOME}/.vim/ftdetect ]; then rm -rf ${HOME}/.vim/ftdetect; fi
mkdir -p ${HOME}/.vim/ftdetect
ln -s ${HOME}/.vim/bundle/ultisnips/ftdetect/* ${HOME}/.vim/ftdetect

echo "Installing plugins"
vim +PluginInstall +qall

echo "done."
