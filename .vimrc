
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-vinegar'

call plug#end()

source ~/.vim/config/vimspector.vim
source ~/.vim/config/coc.nvim

source ~/.vim/config/kodev.vim
source ~/.vim/config/statusbar.vim


" THIS IS FOR fzf
" --- Detect WSL reliably ---
if system('uname -r') =~# 'microsoft'
  let $FZF_TMUX = 0
  let $FZF_DEFAULT_OPTS = '--ansi --layout=reverse --info=inline'
  " Re-enable preview window on the right with Ctrl-/ toggle
  let g:fzf_preview_window = ['right:50%:wrap', 'ctrl-/']
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
endif

" THIS IS FOR vim-vinegar
let g:netrw_banner = 1
let g:netrw_liststyle = 1
