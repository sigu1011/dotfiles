" Tab etting for file type
augroup TabStep
    autocmd BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html  set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css   set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scss  set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rst   set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.md    set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.scala set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb    set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb   set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.c     set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cpp   set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.h     set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.py    set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.go    set tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.scss  set filetype=scss
augroup END

augroup ErrorFormat
    " autocmd BufNewFile,BufRead *.py
    "     \ set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    autocmd BufNewFile,BufRead *.py
        \ set efm=%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
augroup END
