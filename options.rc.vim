" File encoding
if !exists ('g:encoding_set') || !has('nvim')
    set encoding=utf-8
    set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp
    let g:encoding_set=1
endif
scriptencoding utf-8

" Don't create swp file
set nowritebackup
set nobackup
set noswapfile
set noundofile

" set modifiable
" set write

" Show column number
set number
set cursorline
hi CursorLine term=bold ctermfg=Cyan guifg=#80a0ff gui=bold

" Long text
set wrap
set textwidth=0
set colorcolumn=120

" Invisible stirng
set list
set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:$,trail:~

" Colors
" set t_Co=256
" set termguicolors
set background=dark

" Round indent to multipul of shiftwidth
set shiftround

" Don't unload buffer when it is abandones
set hidden

" New load buffer is use open
set switchbuf=useopen

" Smart insert tab setting.
set smarttab

" Excahnge tab to space.
set expandtab

" Auto insert indent.
set autoindent

" Round indent by shiftwidth.
set shiftwidth=4
set shiftround

" Space insert by autoindent
set tabstop=4
set scrolloff=20

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright
" Set minimal width for current window.
set winwidth=30
" Set minimal height for current window.
set winheight=1
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways
" Adjust window size of preview and help.
set previewheight=8
set helpheight=12

" show tab line
set showtabline=2

" Ignore case is search patterns
set ignorecase

" No ignore case when pattern has uppercase
set smartcase

" Search is incremental search
set incsearch

" Show search result highlight
set hlsearch

" Share clipborad with system
set clipboard+=unnamedplus
