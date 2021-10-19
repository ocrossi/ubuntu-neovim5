#!/usr/bin/bash

DENO_INSTALL="/home/nvimuser/.deno";
P3=`which python3`
echo "
export DENO_INSTALL="/home/nvimuser/.deno"
export PATH="$DENO_INSTALL/bin:$PATH:$P3"
" >> /home/nvimuser/.bashrc

source /home/nvimuser/.bashrc
