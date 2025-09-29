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

augroup previewMarkdown
    autocmd!
    autocmd Syntax markdown command! Preview :CocCommand markdown-preview-enhanced.openPreview
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

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" if executable('kitty')
"     augroup SwitchToVIMWindow
"         autocmd!
"         autocmd BufReadPost * execute "silent! !switchtovim"
"     augroup END
" endif

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
" autocmd BufEnter * call NERDTreeRefresh()

" Using vim-php-namespace instead.
" autocmd User Composer nmap <buffer> <LocalLeader>f <Plug>(composer-find) |
"                     \ nmap <buffer> <LocalLeader>u <Plug>(composer-use)

" remove trailing whitespaces and ^M chars
" augroup ws
"   au!
"   autocmd FileType c,cpp,java,php,js,json,css,scss,sass,py,rb,coffee,python,twig,xml,yml,html,phtml,html autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" augroup END

augroup lsp_format
    au!
    autocmd! BufWritePre *.php :LspFormat
augroup END

" enable folding in manual pages based on indentation
augroup man
  au!
  autocmd FileType man setlocal foldmethod=indent foldenable number nolist
augroup END

" nnoremap <leader>; mqA;<esc>`q
" Now using a plugin to insert the semicolon at the end of the line.
augroup semiColon
    au!
    autocmd FileType javascript,css,php,sql,perl,c,cpp nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon) <bar> :w<CR>
    autocmd FileType javascript,css,php,sql,perl,c,cpp imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)
augroup END

" html
" for html files, 2 spaces
augroup twoSpaceForHTML
    au!
    autocmd Filetype html setlocal ts=2 sw=2 expandtab
augroup END

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
augroup breezeJump
    au!
    au FileType html,twig,php,xml,javascript.jsx,typescript,vue nmap <TAB> <Plug>(breeze-next-attribute)
    au FileType html,twig,php,xml,javascript.jsx,typescript,vue nmap <S-TAB> <Plug>(breeze-prev-attribute)
augroup END

" Backup any file when saved using git to ~/.vim-git-backups.
" https://www.reddit.com/r/vim/comments/8w3udw/topnotch_vim_file_backup_history_with_no_plugins/
augroup custom_backup
    autocmd!
    autocmd BufWritePost * call BackupCurrentFile()
augroup END

" Set /usr/share/dict/words as dictionary for markdown files
augroup setDictionary
    autocmd!
    au FileType markdown,text setlocal dictionary+=/usr/share/dict/words
augroup END

" Trigger context aware php completion
" Fix $this-> not work in intelephense and coc.nvim
" augroup phpCompletion
"     autocmd!
    " au FileType php inoremap -> -><c-x><c-o>
    " au FileType php inoremap :: ::<c-x><c-o>
" augroup END

" augroup WPDangIt
"     autocmd!
"     autocmd Filetype markdown,text inoreabbrev wp WP
" augroup END

" augroup Markdown
"   autocmd!
"   autocmd FileType markdown set wrap
" augroup END

augroup JsonFolding
  autocmd!
  autocmd FileType json
                    \ setlocal foldmethod=indent |
                    \ setlocal fillchars=fold:\ |
                    \ setlocal foldtext=NeatFoldText()
                    " \ setlocal foldtext=foldtext()
augroup END

" augroup WPDict
"     autocmd!
"     autocmd FileType php setlocal dictionary+=~/.vim/dict/some-file
" augroup END

" Open help in vertical split
augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

" Disable warning of readonly file editing
augroup NoRo
    au!
    au BufEnter * set noro
augroup END

augroup PHPIndent
    autocmd!
    autocmd FileType php set autoindent
augroup END

augroup UpdateCocLightline
    autocmd!
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

augroup COCCSS
    autocmd!
    autocmd FileType scss setl iskeyword+=@-@
augroup END

augroup TermClose
    autocmd!
    autocmd QuitPre * call <sid>TermForceCloseAll()
augroup END
function! s:TermForceCloseAll() abort
    let term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
    for t in term_bufs
            execute "bd! " t
    endfor
endfunction

" Treat *.jsx as filetype javascript.jsx
" augroup jsxtojsjsx
"     autocmd!
"     autocmd BufRead *.jsx :set filetype=javascript.jsx
" augroup END

" augroup setFormatters
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,typescriptreact,javascript,javascriptreact,json,html,php setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

augroup MojoCommentString
  autocmd!
  autocmd FileType 'html.epl' set commentstring=\\%s
augroup end

augroup intelephenseDocRoot
  autocmd!
  autocmd FileType php let b:coc_root_patterns = ['.git', '.env', 'composer.json', 'artisan']
augroup end

augroup OpenQuickNotes
  autocmd!
  autocmd VimEnter * :e ~/.quick
  " autocmd WinEnter :e ~/.quick
augroup end

augroup DartFormat
  autocmd!
  autocmd BufWritePre *.dart :LspFormat
augroup END

" augroup DartLspDisableInlayHints
"   autocmd!
"   autocmd BufNewFile,BufReadPost *.dart :LspInlayHints toggle
" augroup END

augroup FlutterCodeAction
  autocmd!
  autocmd FileType dart nnoremap <buffer> <space>a :LspCodeAction<CR>
augroup END
