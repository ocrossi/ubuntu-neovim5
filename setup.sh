#!/usr/bin/bash

GCC_INSTALL="/usr/bin/gcc"
PYTHON_INSTALL="/usr/bin/gcc"

echo "
export GCC_INSTALL="/usr/bin/gcc"
export PYTHON_INSTALL="/usr/bin/python3"
export PATH="/bin:$PATH:$GCC_INSTALL"
" >> /home/nvimuser/.bashrc

echo "colorscheme gruvbox" >> /home/nvimuser/.config/nvim/init.vim

source /home/nvimuser/.bashrc

