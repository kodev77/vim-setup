let mapleader = " "

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'tpope/vim-vinegar'

call plug#end()

source ~/.vim/config/vimspector.vim
source ~/.vim/config/coc.nvim

source ~/.vim/config/kodev.vim
source ~/.vim/config/statusbar.vim

