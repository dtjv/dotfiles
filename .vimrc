" general
syntax on
set re=0
set encoding=UTF-8
set updatetime=50

" text
set wrap
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start

" appearance
set noerrorbells
set colorcolumn=80
set textwidth=80
set showmatch
set ruler
set showcmd
set scrolloff=4
set statusline=%f
set cursorline
set signcolumn=yes
set number relativenumber

" search
set incsearch

" tab completion
set wildmenu
set wildmode=longest:full,list

" patterns
set wildignore+=*.zip
set wildignore+=*.pdf
set wildignore+=*/.git/*
set wildignore+=*/node_modules/*

" backup
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

call plug#begin('~/.vim/plugged')

" explorer
Plug 'scrooloose/nerdtree'

" appearance
Plug 'w0ng/vim-hybrid'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/jsonc.vim'
Plug 'editorconfig/editorconfig-vim'

" search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" utils
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'

call plug#end()

let g:mapleader=' '
let g:hybrid_custom_term_colors=1
let g:hybrid_reduced_contrast=1
let g:rg_derive_root='true'
let g:user_emmet_leader_key='<c-e>'
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:coc_global_extensions = [
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-python',
  \ 'coc-tailwindcss'
  \ ]

colorscheme hybrid

autocmd BufRead,BufNewFile *.json set filetype=jsonc

nnoremap <c-h> :wincmd h<CR>
nnoremap <c-j> :wincmd j<CR>
nnoremap <c-k> :wincmd k<CR>
nnoremap <c-l> :wincmd l<CR>
nmap <buffer> <leader>jd <Plug>(coc-definition)
nmap <buffer> <leader>jy <Plug>(coc-type-definition)
nmap <buffer> <leader>ji <Plug>(coc-implementation)
nmap <buffer> <leader>jr <Plug>(coc-references)

" use <tab> to trigger completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <buffer> <silent><expr> <C-space> coc#refresh()

" ui settings 
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeIgnore = ['^node_modules$']

" open/close file manager
nmap <silent> <C-n> :NERDTreeToggle<CR>

" open NERDTree on open file
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" close vim when only window open is NERDTree
augroup VIMCLOSE
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
