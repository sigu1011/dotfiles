function! s:source_rc(path, ...) abort "{{{
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand('~/.config/nvim/' . a:path))
  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let content = map(readfile(abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let tempfile = tempname()
  try
    call writefile(content, tempfile)
    execute 'source' fnameescape(tempfile)
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction"}}}

" vi互換モードを無効にする
if &compatible
  set nocompatible
endif

" reset autogroup
augroup MyAutoCmd
  autocmd!
augroup END

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Load python2, python3
let g:python_host_prog  = expand('~/neovim2/bin/python')
let g:python3_host_prog = expand('~/neovim3/bin/python')

" dein.vim
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " tomlファイル
  let g:rc_dir      = expand("~/.config/nvim/")
  let s:toml        = g:rc_dir . '/dein.toml'
  let s:lazy_toml   = g:rc_dir . '/dein_lazy.toml'
  let s:cpp_toml    = g:rc_dir . '/dein_cpp.toml'
  let s:go_toml     = g:rc_dir . '/dein_go.toml'
  let s:python_toml = g:rc_dir . '/dein_python.toml'

  " tomlを読み込み、キャッシュしておく
  call dein#load_toml(s:toml,        {'lazy': 0})
  call dein#load_toml(s:lazy_toml,   {'lazy': 1})
  call dein#load_toml(s:cpp_toml,    {'lazy': 1})
  call dein#load_toml(s:go_toml,     {'lazy': 1})
  call dein#load_toml(s:python_toml, {'lazy': 1})

  if exists('g:nyaovim_version')
    call dein#add('rhysd/nyaovim-popup-tooltip')
    call dein#add('rhysd/nyaovim-markdown-preview')
    call dein#add('rhysd/nyaovim-mini-browser')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" set true color
set termguicolors

call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')
