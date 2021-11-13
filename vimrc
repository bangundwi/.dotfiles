syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler

highlight Comment ctermfg=green

" colorscheme peachpuff



" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

  Plug 'morhetz/gruvbox'

	Plug 'tpope/vim-commentary'

call plug#end()

" Theme
set background=dark
colorscheme gruvbox
let g:rainbow_active = 1


" Mapping
let g:mapleader=','
noremap <leader>/ :Commentary<CR>

" Setting number
nmap ,r :set relativenumber<CR>
nmap ,rd : set nornu<CR>
" Setting wrap
noremap <leader>z :set linebreak<CR>
noremap <leader>x :set nolinebreak<CR>
" Search
map <CR> :nohlsearch<CR>

" " Map force quit
" nmap <C-C><C-C> :q!

" " Force Write
" nmap ww :w!

" " Force write and quit
" nmap <C-W><C-W> :wq!

"Search
map <CR> :nohlsearch<CR>

" Window Management
" Setting Split
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

augroup rungroup
    autocmd!
    autocmd BufRead,BufNewFile *.go nnoremap ,n :exec '!go run' shellescape(@%, 1)<cr>
    autocmd BufRead,BufNewFile *.py nnoremap ,n :exec '!python3' shellescape(@%, 1)<cr>
    autocmd BufRead,BufNewFile *.js nnoremap ,n :exec '!node' shellescape(@%, 1)<cr>
augroup END

inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
