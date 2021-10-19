" auto-install vim-plug
if empty(glob('/home/nvimuser/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('/home/nvimuser/.config/nvim/autoload/plugged')

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'gcmt/taboo.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jiangmiao/auto-pairs'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'mhartington/formatter.nvim'
"to do
"Plug 'wfxr/minimap.vim'
" test auto complete

" main one
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

"Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc

call plug#end()

colorscheme gruvbox
set background=dark

"-------------------------------------------"
" Personnal binding
"-------------------------------------------"
" ---- PLUGINS ---- "
"NerdTree
nnoremap <C-f> :NERDTreeFocus<cr>
nnoremap <F2> :NERDTreeToggle<cr>	z
"fzf personnal shortcuts
nnoremap <leader>o :Files<cr>
"looks for all files in tree
nnoremap <leader>g :GFiles<cr>
"looks for files in git repo only
nnoremap <leader>b :Buffers<cr>
"looks for files in opened buffers
nnoremap <leader>f :Rg!<cr>
