function! ScratchBASH()
    e! $HOME/repos/bash-playground/bash-scratch.sh
"     setlocal filetype=sh
"     :% norm dig
"     let content =<< trim END
" #!/usr/bin/env bash
"
"
"     END
"     call setline(1, content)
"     :3
endfunction

" TODO: Convert to a perl playground
function! ScratchPERL()
    edit! $HOME/repos/perl-playground/playground.pl
    :8
endfunction
" function! ScratchPERL()
"     noswapfile enew!
"     " setlocal buftype=nofile
"     setlocal buftype=nowrite
"     " setlocal bufhidden=hide
"     " setlocal nobuflisted
"     setlocal filetype=perl
"     lcd ~
"     file PERL
"     let content =<< trim END
"                 use strict;
"                 use warnings;
"                 use warnings FATAL => 'all';
"                 use 5.34.0;
"                 # use diagnostics; # When encountering an error, it will try to explain it.
"                 # use Data::Dumper qw(Dumper);"
"
"     END
"     call setline(1, content)
"     :7
" endfunction

function! ScratchJS()
  edit! $HOME/repos/javascript-playground/index.ts
endfunction
" function! ScratchJS()
"     noswapfile enew!
"     " setlocal buftype=nofile
"     setlocal buftype=nowrite
"     " setlocal bufhidden=hide
"     " setlocal nobuflisted
"     setlocal filetype=javascript
"     lcd ~
"     file JAVASCRIPT
"     let content =<< trim END
"                 console.log('Hello World!');
"
"     END
"     call setline(1, content)
" endfunction

function! ScratchLUA()
    e! $HOME/repos/lua-scripts/playground.lua
endfunction

function! ScratchC()
    e! $HOME/repos/c-playground/playground.c
endfunction

function! ScratchRUBY()
    e! $HOME/repos/ruby-playground/playground.ru
endfunction

" Using it like ScratchRUST
" in order to make use of completion.
" Otherwise, unlike in ScratchPERL, the completion does not work.
function! ScratchPHP()
    e! $HOME/repos/php-playground/src/php-scratch.php
    " setlocal filetype=php
    " :% norm dig
    " let content =<< trim END
    "             <?php
    "             declare(strict_types=1);
    "
    "             require_once __DIR__ . '/../vendor/autoload.php';
    "             require_once 'helpers.php';
    "
    "             use Carbon\Carbon;
    "
    "             use function Scratch\writeln;
    "
    "
    "
    " END
    " call setline(1, content)
    " :10
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
    e! $HOME/repos/v-playground/v_scratch/src/main.v
    " e! /tmp/vlang-scratch-file.v
    " setlocal filetype=v
    " :% norm dig
    " let content =<< trim END
    "             fn main() {
    "                 println("Hello World!");
    "             }
    " END
    " call setline(1, content)
    " :2
    " w!
endfunction

function! ScratchDart()
  e! $HOME/repos/dart-playground/playground/bin/playground.dart
endfunction

function! ScratchGolang()
  edit! $HOME/repos/golang-playground/main.go
endfunction
" function! ScratchGolang()
"     e! /tmp/golang-scratch-file.go
"     setlocal filetype=go
"     :% norm dig
"     let content =<< trim END
" package main
"
" import "fmt"
"
" func main() {
"     fmt.Println("hello world")
" }
"     END
"     call setline(1, content)
"     :6
"     w!
" endfunction

" function! RunVLangScript()
"     write %
"     FloatermNew
"         \ --height=0.98 --width=0.95
"         \ --position=center
"         \ --disposable
"         \ --name=rustconsole
"         \ --title=VLangPlayground
"         \ --autoclose=0
"         \ bash --norc -c "/usr/local/bin/v crun  /tmp/vlang-scratch-file.v"
" endfunction


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

" Run current buffer as Perl code
" command! -nargs=? RunPerl :w !perl -- - <args>
" command! NewPerl :call ScratchPERL()

" Run current buffer as JavaScript code
" command! -nargs=? RunJS :w !bun -- - <args>
" command! NewJS :call ScratchJS()

" Run current buffer as Ruby code
" command! -nargs=? RunRuby :w !ruby -- - <args>
" command! NewRuby :call ScratchRUBY()

" Run current buffer as Bash shell script
" command! RunBash :w !bash
" command! -nargs=? RunBash :!clear;bash --noprofile --norc % <args>
" command! NewBash :call ScratchBASH()

" Run current buffer as Lua code
" command! RunLua :w !lua
" command! RunLua :w !$HOME/luajit21/bin/luajit
" command! RunLua :lcd %:h | w !$HOME/luajit21/bin/luajit
" command! -nargs=? RunLua :lcd %:h | !clear;$HOME/luajit21/bin/luajit % <args>
" command! NewLua :call ScratchLUA()

" Run current buffer as PHP code
" Command abbreviation: rh
" ATTENTION: Depends on current working directory
" command! RunPHP :w !phpo
" This handles the working directory problem
" command! RunPHP :lcd %:h | w !phpo
" Below is the working one before arguments.
" command! RunPHP :!clear;phpo %
" command! RunPHP :up | w !phpo
" Command abbreviation: nh
" command! -nargs=? RunPHP :!clear;phpo % <args>
" command! NewPHP :call ScratchPHP()


" Run current buffer as C code with tcc
" command! RunC :lcd %:h | !clear;/usr/bin/tcc -run %
" command! -nargs=? RunC :lcd %:h | !clear;/usr/bin/tcc -run % <args>
" command! NewC :call ScratchC()

" There is :rc command abbreviation for this command
" in abbreviations.vimrc
command! RunCargo :w | !clear && cargo run --quiet
" Run current buffer as single file rust script.
" Requires rust-nightly.
" There is :rs command abbreviation for this command
" in abbreviations.vimrc
" command! -nargs=? RunRust :w | !clear;cargo +nightly -Zscript --quiet % <args>
" command! RunRust :silent! call RunRustScript()
" Create a new rust single file buffer
" command! NewRust :call ScratchRUST()

" Below one runs like the rust version, in a floaterm
" command! RunVLang :silent! call RunVLangScript()
" command! RunVLang :w !v
" command! -nargs=? RunVLang :!clear;v run % <args>
" command! NewVLang :call ScratchVLang()

" command! -nargs=? RunDart :!clear;dart --enable-asserts % <args>
" command! NewDart :call ScratchDart()

" command! RunGolang :w !go run %
" command! -nargs=? RunGolang :w | :!clear;go run % <args>
" command! NewGolang :call ScratchGolang()

" command! -nargs=* RunBufferAsScript :call RunBufferAsScript("<args>")
" command! -nargs=* RunBufferAsScript :call RunBufferAsScript()
