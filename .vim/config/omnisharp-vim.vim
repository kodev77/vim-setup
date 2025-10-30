" ---------- OmniSharp Configuration ----------

" ---- OmniSharp-Vim logging ----
" let g:OmniSharp_loglevel = 'debug'
" let g:OmniSharp_logfile = expand('~/.omnisharp-vim.log')

" Use .NET 6+ runtime for OmniSharp server
let g:OmniSharp_server_use_net6 = 1

" Used manual download option, point to server path to local files
" let g:OmniSharp_server_path = expand('~/.local/share/omnisharp/OmniSharp')

" Auto-start server when opening .cs files
" let g:OmniSharp_start_server = 1

" Better syntax highlighting and diagnostics
let g:OmniSharp_popup = 1
let g:OmniSharp_highlighting = 3
let g:OmniSharp_diagnostic_enable = 1
let g:OmniSharp_diagnostic_show_symbol = 1

let g:OmniSharp_server_stdio = 1

" Completion setup
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

" Format Tab (.editorconfig)
autocmd FileType cs setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" Format before saving
autocmd BufWritePre *.cs OmniSharpCodeFormat

" If you use fzf or telescope-like tools
let g:OmniSharp_selector_ui = 'fzf'

" ---------- Key Mappings ----------
" already mapped in .vimrc file
" let mapleader = " "  " Space as leader


" ===================================
"  C#-specific OmniSharp key mappings
" ===================================

augroup omnisharp_maps
  autocmd!

  " Only apply inside C# buffers
  autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
  autocmd FileType cs nnoremap <buffer> gi :OmniSharpFindImplementations<CR>  
  autocmd FileType cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
  autocmd FileType cs nnoremap <buffer> pi :OmniSharpPreviewImplementation<CR>
  autocmd FileType cs nnoremap <buffer> <leader>rn :OmniSharpRename<CR>
  autocmd FileType cs nnoremap <buffer> <leader>ca :OmniSharpCodeActions<CR>
  autocmd FileType cs nnoremap <buffer> <leader>fm :OmniSharpCodeFormat<CR>
  autocmd FileType cs nnoremap <buffer> K :OmniSharpDocumentation<CR>
  autocmd FileType cs nnoremap <buffer> <leader>os :OmniSharpStatus<CR>
augroup END

