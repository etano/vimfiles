#!/bin/bash

echo "Creating link from ${HOME}/.vimrc to ${PWD}/vimrc"
if [ -e ${HOME}/.vimrc ]; then rm ${HOME}/.vimrc; fi
ln -sf ${PWD}/vimrc ${HOME}/.vimrc

echo "Creating link from ${HOME}/.vim to ${PWD}"
if [ -e ${HOME}/.vim ]; then
  if [ -L ${HOME}/.vim ]; then rm ${HOME}/.vim; else rm -rf ${HOME}/.vim; fi
fi
ln -sf ${PWD} ${HOME}/.vim

echo "Installing plugins"
vim +PlugInstall

echo "done."
