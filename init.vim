" Specify a directory for plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
"Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
" Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
"Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mhartington/oceanic-next'

" Initialize plugin system
call plug#end()

" Basic Settings
" User , as leader key
let mapleader = ','
set number
set clipboard+=unnamedplus
set pastetoggle=<f2>
set nopaste
" To auto-remove trailing white spaces on save
autocmd BufWritePre * %s/\s\+$//e
set noshowmode
set noswapfile
set cursorline
" indentation settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase
" Prevent vim from auto inserting
" Comments
au BufEnter * set fo-=c fo-=r fo-=o


" Reload file when changes from external editor
set autoread
au FocusGained,BufEnter * :silent! !

" Remember cursor position between vim sessions
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz


" Show effects of find and replace
" in a split window
set inccommand=split

" No need for ex mode
nnoremap Q <nop>

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Theme settings
syntax enable
colorscheme OceanicNext
" colorscheme gruvbox

" vim-airline ---------------------------------------------------------------{{{

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#mike#enabled = 0
set hidden
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#neomake#error_symbol='• '
let g:airline#extensions#neomake#warning_symbol='•  '
let g:airline_symbols.branch = ''
let g:airline_theme='oceanicnext'
cnoreabbrev <silent> <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
nmap <leader>t :term<cr>
nmap <leader>, :bnext<CR>
tmap <leader>, <C-\><C-n>:bnext<cr>
nmap <leader>. :bprevious<CR>
tmap <leader>. <C-\><C-n>:bprevious<CR>
tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#buffer_idx_format = {
            \ '0': '0 ',
            \ '1': '1 ',
            \ '2': '2 ',
            \ '3': '3 ',
            \ '4': '4 ',
            \ '5': '5 ',
            \ '6': '6 ',
            \ '7': '7 ',
            \ '8': '8 ',
            \ '9': '9 ',
            \}

"}}}



" default python-------------------------------------------------------------------{{{
" It is recommended to set up a serperate python environment for neovim
" in both python2 and python3 to avoid reinstalling neovim python package

" Use miniconda3 or anaconda3
if isdirectory(expand('~/miniconda3/envs/vim_env3/bin/'))
let g:python3_host_prog = expand('~/miniconda3/envs/vim_env3/bin/python')
endif
if isdirectory(expand('~/miniconda3/envs/vim_env2/bin/'))
let g:python_host_prog = expand('~/miniconda3/envs/vim_env2/bin/python')
endif

if isdirectory(expand('~/anaconda3/envs/vim_env3/bin/'))
let g:python3_host_prog = expand('~/anaconda3/envs/vim_env3/bin/python')
endif
if isdirectory(expand('~/anaconda3/envs/vim_env2/bin/'))
let g:python_host_prog = expand('~/anaconda3/envs/vim_env2/bin/python')
endif
" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",
    "\ "Modified"  : "#d9bf91",
    "\ "Renamed"   : "#51C9FC",
    "\ "Untracked" : "#FCE77C",
    "\ "Unmerged"  : "#FC51E6",
    "\ "Dirty"     : "#FFBD61",
    "\ "Clean"     : "#87939A",
    "\ "Ignored"   : "#808080"
    "\ }


let g:NERDTreeIgnore = ['^node_modules$']


" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
