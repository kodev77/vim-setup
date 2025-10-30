" Always show the statusline
set laststatus=2

" Custom statusline: file path + position info
set statusline=%F%=%l,%c\ [%p%%]

highlight StatusLine ctermfg=green ctermbg=black guifg=#00FF00 guibg=#000000
highlight StatusLineNC ctermfg=black ctermbg=DarkGreen guifg=#000000 guibg=#008000

