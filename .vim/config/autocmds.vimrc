" for html and javascript files, 2 spaces
augroup tabForWeb
    autocmd!
    autocmd Filetype html,javascript.jsx setlocal ts=2 sw=2 expandtab
augroup END

" JavaScript specific folding
" Enable folding but close folds when buffer is opened.
augroup jsFold
    autocmd!
    autocmd Syntax javascript.jsx setlocal foldmethod=syntax
    autocmd Syntax javascript.jsx normal zR
augroup END

" create directory on save if it does not exist
" http://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
" You can use a plugin for this https://github.com/pbrisbin/vim-mkdir
" Or this plugin: https://github.com/duggiefresh/vim-easydir
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" if you prefer the omni-completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" This is disabled due to being a suspect of slow scrolling.
" autocmd cursormovedi * if pumvisible() == 0|pclose|endif
" autocmd insertleave * if pumvisible() == 0|pclose|endif

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" autocommands by admin
" augroup filetype_html
"     autocmd!
"
"     " format html
"     autocmd BufWritePre *.html :normal gg=G
" augroup END

" http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
augroup QFClose
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup END

" If created file has a template, use that.
augroup CreateFromTemplate
    autocmd!
    autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
augroup END

" Auto refresh NERDTree when entering its window
autocmd BufEnter * call NERDTreeRefresh()

" Using vim-php-namespace instead.
" autocmd User Composer nmap <buffer> <LocalLeader>f <Plug>(composer-find) |
"                     \ nmap <buffer> <LocalLeader>u <Plug>(composer-use)

" remove trailing whitespaces and ^M chars
augroup ws
  au!
  autocmd FileType c,cpp,java,php,js,json,css,scss,sass,py,rb,coffee,python,twig,xml,yml,html,phtml,html autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
augroup END

" enable folding in manual pages based on indentation
augroup man
  au!
  autocmd FileType man setlocal foldmethod=indent foldenable number nolist
augroup END

" nnoremap <leader>; mqA;<esc>`q
" Now using a plugin to insert the semicolon at the end of the line.
autocmd FileType javascript,css,php nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css,php imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
augroup END

" autoformat javascript files using prettier
" augroup formatprettier
"     au!
"     autocmd FileType javascript set formatprg=prettier\ --stdin
" augroup END

" Move to the next attribute using <tab> and <s-tab> in html.
augroup breeze-jump
    au FileType html,twig,php,xml,javascript.jsx,vue nmap <TAB> <Plug>(breeze-next-attribute)
    au FileType html,twig,php,xml,javascript.jsx,vue nmap <S-TAB> <Plug>(breeze-prev-attribute)
augroup END

" Backup any file when saved using git to ~/.vim-git-backups.
" https://www.reddit.com/r/vim/comments/8w3udw/topnotch_vim_file_backup_history_with_no_plugins/
augroup custom_backup
    autocmd!
    autocmd BufWritePost * call BackupCurrentFile()
augroup END

" Set /usr/share/dict/words as dictionary for markdown files
augroup set-dictionary
    au FileType markdown,text setlocal dictionary+=/usr/share/dict/words
augroup END

" Trigger context aware php completion
augroup php-completion
    autocmd!
    au FileType php inoremap -> -><c-x><c-o>
    au FileType php inoremap :: ::<c-x><c-o>
augroup END

augroup WPDangIt
    autocmd!
    autocmd Filetype markdown,text inoreabbrev wp WP
augroup END

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
augroup END

" augroup WPDict
"     autocmd!
"     autocmd FileType php setlocal dictionary+=~/.vim/dict/some-file
" augroup END

augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END
