" Trim all trailing whitespaces no questions asked.
command! FixWhitespace :call FixWhitespace()
function! FixWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

let l = line(".")
let c = col(".")

" Restore cursor position
call cursor(l, c)

let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

" This section is disabled cause it's causing glitches
" in terminal when pasting clipboard.
" execute "set <f28>=\<Esc>[200~"
" execute "set <f29>=\<Esc>[201~"
" map <expr> <f28> XTermPasteBegin("i")
" imap <expr> <f28> XTermPasteBegin("")
" vmap <expr> <f28> XTermPasteBegin("c")
" cmap <f28> <nop>
" cmap <f29> <nop>

function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

let s:custom_backup_dir=get(g:, 'vim_git_backups_directory', '~/.vim-git-backups')
function! BackupCurrentFile()
  if !isdirectory(expand(s:custom_backup_dir))
    let cmd = 'mkdir -p ' . s:custom_backup_dir . ';'
    let cmd .= 'cd ' . s:custom_backup_dir . ';'
    let cmd .= 'git init;'
    call system(cmd)
  endif
  let file = expand('%:p')
  if file =~ fnamemodify(s:custom_backup_dir, ':t') | return | endif
  let file_dir = s:custom_backup_dir . expand('%:p:h')
  let backup_file = s:custom_backup_dir . file
  let cmd = ''
  if !isdirectory(expand(file_dir))
    let cmd .= 'mkdir -p ' . file_dir . ';'
  endif
  let cmd .= 'cp ' . file . ' ' . backup_file . ';'
  let cmd .= 'cd ' . s:custom_backup_dir . ';'
  let cmd .= 'git add ' . backup_file . ';'
  let cmd .= 'git commit -m "Backup - `date`";'
  call job_start(['sh', '-c', cmd])
endfunction

function! OpenCurrentFileBackupHistory()
  let backup_dir = expand(s:custom_backup_dir . expand('%:p:h'))
  let cmd = "cd " . backup_dir
  let cmd .= "; git log -p --since='1 month' " . expand('%:t')

  silent! exe "noautocmd botright pedit vim_git_backups"
  noautocmd wincmd P
  set buftype=nofile
  exe "noautocmd r! ".cmd
  exe "normal! gg"
  noautocmd wincmd p
endfunction

function! NeatFoldText()
    let foldchar         = matchstr(&fillchars, 'fold:\zs.')
    let lines_count      = v:foldend - v:foldstart + 1
    let lines_count_text = printf("┈─ %1s lines ─┈", lines_count) . repeat(foldchar, 10)
    let foldtextstart    = repeat(' ', indent(nextnonblank(v:foldstart))) . " ••• " 
    let foldtextend      = lines_count_text . repeat(foldchar, 8)
    let foldtextlength   = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn

    " return foldtextstart . repeat(foldchar, winwidth(0) - foldtextlength) . foldtextend
    return foldtextstart . " " . foldtextend
endfunction

function! ScratchBASH()
    " e! /tmp/php-scratch-file.php
    e! $HOME/repos/bash-playground/bash-scratch.sh
    setlocal filetype=sh
    :% norm die
    let content =<< trim END
#!/usr/bin/env bash


    END
    call setline(1, content)
    :3
endfunction

function! ScratchPERL()
    noswapfile enew!
    " setlocal buftype=nofile
    setlocal buftype=nowrite
    " setlocal bufhidden=hide
    " setlocal nobuflisted
    setlocal filetype=perl
    lcd ~
    file PERL
    let content =<< trim END
                use strict;
                use warnings;
                use warnings FATAL => 'all';
                use 5.34.0;
                # use diagnostics; # When encountering an error, it will try to explain it.
                # use Data::Dumper qw(Dumper);"
                
    END
    call setline(1, content)
    :7
endfunction

function! ScratchJS()
    noswapfile enew!
    " setlocal buftype=nofile
    setlocal buftype=nowrite
    " setlocal bufhidden=hide
    " setlocal nobuflisted
    setlocal filetype=javascript
    lcd ~
    file JAVASCRIPT
    let content =<< trim END
                console.log('Hello World!');
                
    END
    call setline(1, content)
endfunction

" " This is the first version
" " that uses a buffer with not file
" function! ScratchLUA()
"     noswapfile enew!
"     " setlocal buftype=nofile
"     setlocal buftype=nowrite
"     " setlocal bufhidden=hide
"     " setlocal nobuflisted
"     setlocal filetype=lua
"     lcd ~
"     file LUA
" endfunction

function! ScratchLUA()
    e! $HOME/repos/lua-scripts/playground.lua
endfunction

function! ScratchC()
    e! $HOME/repos/c-playground/playground.c
endfunction

function! ScratchRUBY()
    e! $HOME/repos/ruby-playground/playground.rb
endfunction

" Using it like ScratchRUST
" in order to make use of completion.
" Otherwise, unlike in ScratchPERL, the completion does not work.
function! ScratchPHP()
    " e! /tmp/php-scratch-file.php
    e! $HOME/repos/php-playground/src/php-scratch.php
    setlocal filetype=php
    :% norm die
    let content =<< trim END
                <?php
                declare(strict_types=1);

                require_once __DIR__ . '/../vendor/autoload.php';
                require_once 'helpers.php';

                use Carbon\Carbon;

                use function Scratch\writeln;



    END
    call setline(1, content)
    :10
endfunction

function! ScratchRUST()
    e! /tmp/rust-scratch-file.rs
    setlocal filetype=rust
    :% norm die
    let content =<< trim END
                ---cargo
                [dependencies]
                # clap = { version = "4.2", features = ["derive"] }
                # rand = "0.8.5"
                ---

                fn main() {
                    println!("Hello World!");
                }
    END
    call setline(1, content)
    :8
    w!
endfunction

function! ScratchVLang()
    e! /tmp/vlang-scratch-file.v
    setlocal filetype=vlang
    :% norm die
    let content =<< trim END
                fn main() {
                    println("Hello World!");
                }
    END
    call setline(1, content)
    :2
    w!
endfunction

function! ScratchDart()
    e! $HOME/repos/dart-playground/playground/bin/playground.dart
    " setlocal filetype=dart
    " :% norm die
    " let content =<< trim END
    "             void main() {
    "               print('Hello World!');
    "             }
    " END
    " call setline(1, content)
    " :2
    " w!
endfunction

function! ScratchGolang()
    e! /tmp/golang-scratch-file.go
    setlocal filetype=go
    :% norm die
    let content =<< trim END
package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
    END
    call setline(1, content)
    :6
    w!
endfunction

function! RunVLangScript()
    write %
    " sleep 900m
    " :!clear;cargo +nightly -Zscript --quiet %
    FloatermNew
        \ --height=0.98 --width=0.95
        \ --position=center
        \ --disposable
        \ --name=rustconsole
        \ --title=VLangPlayground
        \ --autoclose=0
        \ bash --norc -c "/usr/local/bin/v crun  /tmp/vlang-scratch-file.v"
endfunction


function! RunRustScript()
    write %
    " sleep 900m
    " :!clear;cargo +nightly -Zscript --quiet %
    FloatermNew
        \ --height=0.98 --width=0.95
        \ --position=center
        \ --disposable
        \ --name=rustconsole
        \ --title=RustPlayground
        \ --autoclose=0
        \ bash --norc -c "cargo +nightly -Zscript --quiet /tmp/rust-scratch-file.rs"
    " :!kitty @ --to unix:/tmp/mykitty launch --no-response --hold --type=window cargo +nightly -Zscript /tmp/rust-scratch-file.rs
    " :silent! !kitty @ --to unix:/tmp/mykitty launch --hold cargo +nightly -Zscript /tmp/rust-scratch-file.rs
endfunction

" Serve current buffer's working directory using PHP's built-in server
" FIXME: Calling multiple times
function! PHPServer()
    let cwd  = getcwd()
    let port = system('get_random_port.sh')
    let file = buffer_name('%')
    let cmd  = printf('FloatermNew --title=PHPServer --silent /usr/bin/php -n -S localhost:%s -t %s', port, cwd)
    " echo cmd
    execute cmd
    call system(printf('xdg-open http://localhost:%s/%s', port, file))
endfunction

function! RunBufferAsScript(...)
    let b:mft = &filetype
    if b:mft == "php"
        execute ':RunPHP' . ' ' . join(a:000, ' ')
    elseif b:mft == "sh"
        execute ':RunBash' . ' ' . join(a:000, ' ')
    elseif b:mft == "c"
        execute ':RunC' . ' ' . join(a:000, ' ')
    elseif b:mft == "perl"
        execute ':RunPerl' . ' ' . join(a:000, ' ')
    elseif b:mft == "lua"
        execute ':RunLua' . ' ' . join(a:000, ' ')
    elseif b:mft == "vlang"
        execute ':RunVLang' . ' ' . join(a:000, ' ')
    elseif b:mft == "ruby"
        execute ':RunRuby' . ' ' . join(a:000, ' ')
    elseif b:mft == "go"
        execute ':RunGolang' . ' ' . join(a:000, ' ')
    elseif b:mft == "rust"
        execute ':RunRust' . ' ' . join(a:000, ' ')
    elseif b:mft == "dart"
        execute ':RunDart' . ' ' . join(a:000, ' ')
    elseif b:mft == "javascript"
        execute ':RunJS' . ' ' . join(a:000, ' ')
    endif
endfunction
nnoremap <leader>r :call RunBufferAsScript()<cr>

function! FormatVlang(buffer) abort
    return {'command': 'v fmt'}
endfunction
execute ale#fix#registry#Add('vfmt', 'FormatVlang', ['vlang'], 'v fmt for vlang')

function! FormatPHP(buffer) abort
    return {'command': 'phpcs --standard=PSR12 --cache -q'}
endfunction
execute ale#fix#registry#Add('phpcs', 'FormatPHP', ['php'], 'phpcs for php')

" Used by the command 'SnpSyn'
function! HandleSnpSyn(syn)
    let line = search('type=')
    call setline(line, "type='" . a:syn . "'")
endfunction

" Used by the command 'SnpParent'
function! HandleSnpParent(parent)
    let [pid, ptitle] = split(a:parent, "\t")
    let line = search('\[parent\]')
    call setline(line + 1, "id='" . pid . "' # " . ptitle)
endfunction

" Used by the command 'SnpSave'
function! HandleSnpSave()
    silent! w
    let job = job_start('snippet-writer-v save -f ' . expand("%"), {"callback": "SnpSaveHandler"})
endfunction

function! SnpSaveHandler(channel, msg)
    if a:msg == 'success'
        " silent! RemoveFileAndBuffer
        call RemoveFileAndBuffer(1)
        echom 'Snippet saved succesfully!.'
    else
        echohl WarningMsg | echom a:msg | echohl None
    endif
endfunction

function! LoadAvg()
    " let cmd = 'bash --norc --noprofile -c "loadavg"'
    return system('loadavg')
endfunction

" <leader>1-9 is mapped to this function
function! GotoBuffer(n)
    " Initialize an empty list to store buffer names
    let l:buffer_list = []

    " Iterate through all buffer numbers
    for l:bufnr in range(1, bufnr('$'))
        " Check if the buffer is listed (i.e., it is loaded)
        if buflisted(l:bufnr)
            " Get the buffer name and add it to the list
            let l:buffer_name = bufname(l:bufnr)
            call add(l:buffer_list, l:buffer_name)
        endif
    endfor

    execute 'b' l:buffer_list[a:n - 1]
endfunction


function! RemoveFileAndBuffer(skipConfirm = 0)
    let choice = 0
    if a:skipConfirm == 0
        let choice = confirm("Trash this file? Default: No",
                    \ "&Yes\n&No", 2)
    else
        let choice = 1
    endif
    if choice == 1
        call system('rip --graveyard ~/.local/share/Trash/rip ' . expand('%'))
        bdelete!
    else
        echo "Cancelled!"
    endif
endfunction

function! FlutterRun()

    if &filetype != 'dart'
        call EchoMessage('Not a Dart file!')
        return 0
    endif

    let parent_basename = fnamemodify(getcwd(), ':t')
    let pid_file = '/tmp/flutter_' . parent_basename . '.pid'

    if filereadable(pid_file)
        call EchoMessage('App is already running!')
        return 0
    endif

    if getbufinfo('%')[0].changed
        write
    endif
    call EchoMessage('Attempting to start the app, please wait...')
    call job_start([
                \ 'kitty',
                \ '@',
                \ '--to',
                \ 'unix:/tmp/mykitty',
                \ 'launch',
                \ '--type',
                \ 'window',
                \ '--dont-take-focus',
                \ '--copy-env',
                \ '--cwd',
                \ getcwd(),
                \ 'fltr',
                \ '-t',
                \ expand('%')])

    " let timer = timer_start(1000, 'CheckFile', {'repeat': -1})
    let timer = timer_start(1000, {timer -> CheckFile(timer, pid_file)}, {'repeat': 10})
endfunction

" Used in FlutterRun as a timer callback
function! CheckFile(timer, pid_file)
    if filereadable(a:pid_file)
        call EchoMessage('App has started to run!')
        call timer_stop(a:timer)
    endif
endfunction

function! FlutterReload()
    let parent_basename = fnamemodify(getcwd(), ':t')
    let pid_file = '/tmp/flutter_' . parent_basename . '.pid'
    if filereadable(pid_file)
        if getbufinfo('%')[0].changed
            write
        endif
        let pid = readfile(pid_file)
        call system('kill -usr1 ' . pid[0])
    else
        call EchoMessage('Couldnot get the pid from: ' . pid_file)
        call FlutterRun()
        return 0
    endif
endfunction

function! FlutterRestart()
    let parent_basename = fnamemodify(getcwd(), ':t')
    let pid_file = '/tmp/flutter_' . parent_basename . '.pid'
    if filereadable(pid_file)
        if getbufinfo('%')[0].changed
            write
        endif
        let pid = readfile(pid_file)
        call system('kill -usr2 ' . pid[0])
    else
        call EchoMessage('Couldnot get the pid from: ' . pid_file)
        call FlutterRun()
        return 0
    endif
endfunction

function! FlutterStop()
    let parent_basename = fnamemodify(getcwd(), ':t')
    let pid_file = '/tmp/flutter_' . parent_basename . '.pid'
    if filereadable(pid_file)
        let pid = readfile(pid_file)
        call system('kill -term ' . pid[0])
    else
        call EchoMessage('Couldnot get the pid from: ' . pid_file)
        return 0
    endif
endfunction

function! BufferSymbols()
    if &filetype == 'dart'
        :LspDocumentSymbol
    else
        :BTags
    endif
endfunction

function! EchoMessage(msg)
    redraw | echohl WarningMsg | echo a:msg | echohl None
endfunction

" function! TimedEcho(msg, duration)
"     redraw | echohl WarningMsg | echo a:msg | echohl None
"     call timer_start(a:duration, {-> execute('redraw')})
" endfunction
"
" function! Notify(message, type, ...)
"     let duration = get(a:, 1, 3000)
"     
"     if a:type ==# 'error'
"         let highlight = 'ErrorMsg'
"         let border_hl = ['ErrorMsg']
"         let prefix = '✗ '
"     elseif a:type ==# 'warning'
"         let highlight = 'WarningMsg' 
"         let border_hl = ['WarningMsg']
"         let prefix = '⚠ '
"     elseif a:type ==# 'success'
"         let highlight = 'DiffAdd'
"         let border_hl = ['DiffAdd']
"         let prefix = '✓ '
"     else
"         let highlight = 'Normal'
"         let border_hl = ['Comment']
"         let prefix = 'ℹ '
"     endif
"     
"     let options = {
"         \ 'line': 1,
"         \ 'col': 60,
"         \ 'minwidth': 25,
"         \ 'maxwidth': 60,
"         \ 'wrap': 1,
"         \ 'border': [1,1,1,1],
"         \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
"         \ 'highlight': highlight,
"         \ 'borderhighlight': border_hl,
"         \ 'time': duration,
"         \ 'close': 'click',
"         \ }
"     
"     call popup_notification(prefix . a:message, options)
" endfunction
