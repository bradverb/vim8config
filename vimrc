" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if &term=="xterm"
     set t_Co=256
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Allow backspacing over everything in insert mode
set bs=indent,eol,start

" Read/write a .viminfo file, don't store morethan 50 lines of registers
set viminfo='100,<50
set history=500

" Shorten update time for snappier git-gutter
set updatetime=250

" Status line/command line stuff
set ruler
set number
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'Help']
highlight LineNr ctermfg=7
set showcmd
set lazyredraw
set laststatus=2

" Search modifications
set ignorecase
set smartcase
set incsearch

" Auto read when file is changed from outside
set autoread

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable mouse
set mouse=a
" Note that Shift+MiddleClick will paste from other applications

" Sensible default tab/indent settings
set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=8

"Custom settings for python only
autocmd Filetype python setlocal ts=8 et sw=4 sts=4
set wrap

" Wildmenu makes command line completion have a pop up
set wildmenu

" Buffers become hidden when abandoned
set hidden

"Set listchars for when 'list' is set on
set listchars=eol:$,tab:>/,trail:_

"Turn off Error Bells
set noerrorbells
set visualbell
set t_vb=
set tm=500

" Enable fzf if the directory is present in home dir
if isdirectory($HOME . "/.fzf")
    packadd! fzf-vim
endif

" Some settings for NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1

" ##### Keyboard shortcuts / commands / functions #####
" Set <leader> to comma for faster extra commands
let mapleader = ","
let g:mapleader = ","

" Fast Saving
nnoremap <leader>w :w!<CR>

" Fast unhighlighting of searches
nnoremap <leader>n :noh<CR>
nnoremap <leader>m :noh<CR>

" Quick escape from insert mode... should probably pick just one
inoremap kj <Esc>
inoremap KJ <Esc>

" No more "entering ex mode, type 'visual' to continue
noremap Q <Nop>

" Open/close NERDTree with kb shortcut and close if it's the only window
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | end

" Make * and # searches work on selections in visual mode
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"Mappings for F-keys and related settings
set pastetoggle=<F2>
"Default to absolute line numbers, F3 to toggle to relative
let g:enable_numbers = 0
nnoremap <F3> :NumbersToggle<CR>

" Only do this part when compiled with support for autocommands
if has("autocmd")
    augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
    augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
      cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
    endif
    set csverb
endif

"##### Appearance #####
" Lightline config
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" colorscheme
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

"##### Helper Functions #####
function! CmdLine(str)
    .x. "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "<CR>"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "<CR>"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

