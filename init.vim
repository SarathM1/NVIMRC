
" Setup dein  ---------------------------------------------------------------{{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))
  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim')
" syntax
  call dein#add('tpope/vim-fugitive')
  call dein#add('jreybert/vimagit', {'on_cmd': ['Magit', 'MagitOnly']})
  call dein#add('airblade/vim-gitgutter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('neomake/neomake', {'on_cmd': 'Neomake'})
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tpope/vim-surround')
  call dein#add('tomtom/tcomment_vim')
  " FZF
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('mhartington/oceanic-next')

  call dein#add('ryanoasis/vim-devicons')
  call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add('sbdchd/neoformat')

  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()
  filetype plugin indent on
" }}}

" Neovim Settings
  set clipboard+=unnamedplus
  set pastetoggle=<f2>
  set nopaste

  " To auto-remove trailing white spaces on save
  autocmd BufWritePre * %s/\s\+$//e
  set noshowmode
  set noswapfile
  filetype on
  set cursorline
  set  number
  set numberwidth=1

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

  set conceallevel=0
  set virtualedit=
  set wildmenu
  set laststatus=2
  set wrap linebreak nolist
  set wildmode=full
  set autoread
" leader is ,
  let mapleader = ','
  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"
" Remember cursor position between vim sessions
 autocmd BufReadPost *
             \ if line("'\"") > 0 && line ("'\"") <= line("$") |
             \   exe "normal! g'\"" |
             \ endif
             " center buffer around cursor when opening files
  autocmd BufRead * normal zz
  " set updatetime=500
  set complete=.,w,b,u,t,k
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  set formatoptions+=t
  set inccommand=nosplit
  set shortmess=atIc
  set isfname-==
  set spell

" }}}

" System mappings  ----------------------------------------------------------{{{

" No need for ex mode
  nnoremap Q <nop>
" exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi

  " File path completion 'ctr f'
  inoremap <c-f> <c-x><c-f>

" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  vnoremap <c-/> :TComment<cr>
"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
  " syntax on
  " colorscheme slate
  " Or if you have Neovim >= 0.1.5
    if (has("termguicolors"))
    set termguicolors
    endif

    " Theme
    syntax enable
  colorscheme OceanicNext
"}}}

" MarkDown ------------------------------------------------------------------{{{

  noremap <leader>TM :TableModeToggle<CR>
  let g:table_mode_corner="|"

  let g:neomake_markdown_proselint_maker = {
      \ 'errorformat': '%W%f:%l:%c: %m',
      \ 'postprocess': function('neomake#postprocess#GenericLengthPostprocess'),
      \}
  let g:neomake_markdown_enabled_makers = ['alex', 'proselint']

"}}}

" Python --------------------------------------------------------------------{{{

  " let g:python_host_prog = '/usr/local/bin/python2'
  " let g:python3_host_prog = '/usr/bin/python3'
  " " let $NVIM_PYTHON_LOG_FILE='nvim-python.log'
  " let g:jedi#auto_vim_configuration = 0
  " let g:jedi#documentation_command = "<leader>k"

" }}}


" Git -----------------------------------------------------------------------{{{
  set signcolumn=yes
" }}}

" NERDTree ------------------------------------------------------------------{{{

  let g:vimfiler_ignore_pattern = ""
  " map <silent> - :VimFiler<CR>
	let g:vimfiler_tree_leaf_icon = ''
	let g:vimfiler_tree_opened_icon = ''
	let g:vimfiler_tree_closed_icon = ''
	let g:vimfiler_file_icon = ''
	let g:vimfiler_marked_file_icon = '*'
  let g:vimfiler_expand_jump_to_first_child = 0
  " let g:vimfiler_as_default_explorer = 1
  augroup vfinit
  autocmd FileType vimfiler call s:vimfilerinit()
  augroup END
  function! s:vimfilerinit()
      set nonumber
      set norelativenumber
      nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
            \ "\<Plug>(vimfiler_expand_tree)",
            \ "\<Plug>(vimfiler_edit_file)"
            \)
      nmap <silent> m :call NerdUnite()<cr>
      nmap <silent> r <Plug>(vimfiler_redraw_screen)
  endf
  " let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
  let g:webdevicons_enable_vimfiler = 0
  let g:vimfiler_no_default_key_mappings=1
  function! NerdUnite() abort "{{{
    let marked_files =  vimfiler#get_file(b:vimfiler)
    call unite#start(['nerd'], {'file': marked_files})
	endfunction "}}}

  map <silent> - :NERDTreeToggle<CR>
  augroup ntinit
  autocmd FileType nerdtree call s:nerdtreeinit()
  augroup END
  function! s:nerdtreeinit()
      nunmap <buffer> K
      nunmap <buffer> J
  endf
  let NERDTreeShowHidden=1
  let NERDTreeHijackNetrw=0
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:NERDTreeWinSize=45
  let g:NERDTreeAutoDeleteBuffer=1
  let g:WebDevIconsOS = 'Darwin'
  let NERDTreeMinimalUI=1
  let NERDTreeCascadeSingleChildDir=1
  let g:NERDTreeHeader = 'hello'


" let g:webdevicons_conceal_nerdtree_brackets = 0
  " let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
  " 
  let g:NERDTreeShowIgnoredStatus = 0
  " let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 1
  " let g:NERDTreeDirArrows = 1
  let g:NERDTreeDirArrowExpandable = ''
  let g:NERDTreeDirArrowCollapsible = ''
  let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
"}}}

" Vim-Devicons -------------------------------------------------------------0{{{

  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''

" }}}

" Code formatting -----------------------------------------------------------{{{

" ,f to format code, requires formatters: read the docs
  noremap <silent> <leader>f :Neoformat<CR>

" }}}

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

" Linting -------------------------------------------------------------------{{{

  autocmd! BufWritePost * Neomake
  let g:neomake_warning_sign = {'text': '•'}
  let g:neomake_error_sign = {'text': '•'}

"}}}

" FZF -------------------------------------------------------------------{{{

    nnoremap <c-p> :Files<CR>
    nnoremap <Leader>b :Buffers<CR>
    nnoremap <Leader>l :Lines<CR>
    nnoremap <Leader>bl :BLines<CR>
"}}}

" Split  Windows -------------------------------------------------------------------{{{
    nmap sh :split<Return><C-w>w
    nmap sv :vsplit<Return><C-w>w
"}}}

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Save file using Ctrs-------------------------------------------------------------------{{{
   noremap <silent> <C-S>          :update<CR>
   vnoremap <silent> <C-S>         <C-C>:update<CR>
   inoremap <silent> <C-S>         <C-O>:update<CR>

"}}}

" Inset header files automatically-------------------------------------------------------------------{{{
" Reference: https://www.thegeekstuff.com/2008/12/vi-and-vim-autocommand-3-steps-to-add-custom-header-to-your-file/
autocmd bufnewfile *.c so $HOME/vim_templates/c_header.txt
autocmd bufnewfile *.c exe "1," . 10 . "g/File Name:.*/s//File Name: " .expand("%")
autocmd bufnewfile *.c exe "1," . 10 . "g/Date:.*/s//Date: " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.c execute "normal ma"
autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " .strftime("%c")
autocmd bufwritepost,filewritepost *.c execute "normal `a"
"}}}


" Ultisnips-------------------------------------------------------------------{{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories = ["/home/sm/vim_templates/Ultisnips", "Ultisnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
