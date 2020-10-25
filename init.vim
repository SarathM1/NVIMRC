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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'

" LSP and related plugins
" Requires latest nightly build
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'


Plug 'nvim-lua/completion-nvim'   " Nvim completion engine
Plug 'SirVer/ultisnips'           " Snippets engine

Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()


" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Common
syntax enable
set noswapfile        " Do not create swap files
set number            " Display line numbers
set showcmd           " Show typed commands
set showmatch         " Show matching parenthesis
"set cmdheight=1       " Command line height
set cursorline        " Highlight current line


set wildmenu          " Visual autocomplete for command menu
set wildmode=longest:list,full
"set laststatus=2      " Always diplay status bar
set noshowmode        " Don't show current vim mode
"set updatetime=250    " Update time 250ms


set backspace=indent,eol,start " Backspace through lines


" Search
set ignorecase         " The case of normal letters is ignored.
set smartcase          " Ignore case when the pattern contains lowercase letters only.
set incsearch          " Start searching before pressing enter
set nows               " Once hitting the search bottom it stops instead of restarting from the first match
set hlsearch          " Enable hlsearch
" Show effects of find and replace
" in a split window
set inccommand=split

"Formatting
set autoindent        " Auto indentation. To paste use paste mode: :set paste
set wrap              " Wrap long lines
set shiftwidth=4      " Use indents of 4 spaces
set expandtab         " Tabs are spaces, not tabs
set tabstop=4         " An indentation every four columns
set nojoinspaces      " Prevents inserting two spaces after punctuation on a join (J)
set splitright        " Puts new vsplit windows to the right of the current
set splitbelow        " Puts new split windows to the bottom of the current
set softtabstop=4
set shiftround

" Theme settings
if has('nvim') || has('termguicolors')
  set termguicolors
endif
colorscheme OceanicNext

"colorscheme gruvbox

" Basic Settings
" Use Ctrl-s to save
noremap <c-s> :update<CR>
" User , as leader key
let mapleader = ','
set clipboard+=unnamedplus
set pastetoggle=<f2>
set nopaste
" To auto-remove trailing white spaces on save
autocmd BufWritePre * %s/\s\+$//e
" Make search case insensitive
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



" No need for ex mode
nnoremap Q <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv


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
nmap <leader>t :term<cr>
nmap <leader>, :bnext<CR>
nmap <leader>. :bprevious<CR>
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
if isdirectory(expand('/Users/sarath/.pyenv/shims/'))
    let g:python3_host_prog = expand('/Users/sarath/.pyenv/shims/python3')
    let g:python_host_prog = expand('/Users/sarath/.pyenv/shims/python2')
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


" Fzf.vim settings
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
"FZF key-bindings in normal mode
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Ag<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>


" LSP Settings start
lua << EOF
require'nvim_lsp'.pyls.setup{on_attach=require'diagnostic'.on_attach}
EOF

set completeopt-=preview

" use omni completion provided by lsp
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)

" LSP configuration
nnoremap <leader>gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>af    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ar    <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <leader>=     <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>ai    <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <leader>ao    <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <c-l> <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> <leader>n :NextDiagnosticCycle<CR>

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 1

let g:diagnostic_show_sign = 0
" Use below options only if show_sign = 1
"call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
"call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
"call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
"call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

" LSP Settings stop

" highlight text being yanked
augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
