#!/usr/bin/bash

DENO_INSTALL="/home/nvimuser/.deno";
P3=`which python3`
echo "
export GCC_INSTALL="/usr/bin/gcc"
export PYTHON_INSTALL="/usr/bin/python3"
export PATH="/bin:$PATH:$GCC_INSTALL:$PYTHON_INSTALL"
" >> /home/nvimuser/.bashrc

echo "colorscheme gruvbox\n" >> /home/nvimuser/.config/nvim/init.vim

source /home/nvimuser/.bashrc

