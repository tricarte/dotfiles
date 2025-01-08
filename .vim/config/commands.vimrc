" for when you forget to sudo.. really write the file.
" http://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission/
command! W :execute ':silent w !sudo tee % >/dev/null' | :edit!

" revert file
command! Revert :e!

" close all buffers
command! CloseAll :bufdo! :BD

" remove search results
" command! H let @/=""

" toggle line numbering
" It's not working.
" command! ToggleNumber :set number! " there is no need to put <cr> for commands

" Php CS fix file and directory
command! CSFix :call PhpCsFixerFixFile()<CR>
command! CSFixDir :call PhpCsFixerFixDirectory()<CR>

" json pretty print
function! JSONify()
  %!python3 -mjson.tool
  set syntax=json
endfunction
command! Jsonify :call JSONify()

" make current buffer executable
" command! Chmodx :!chmod a+x %
command! Chmodx :AsyncRun chmod +x %

command! Whereami :call DisplayEnclosingLine()

" Generate docblock.
" Using Doge now
" command! Docblock :call pdv#DocumentWithSnip()<CR>

" Copy content to ~/.clipboard to make it available through copying over SSH.
" command! Clipboard :sav ~/.clipboard
command! -range=% Clipboard  <line1>,<line2>:w! ~/.clipboard

" Fix weird DOS characters.
command! FixDos :e ++ff=dos

command! -bang Docs call fzf#vim#files('~/Documents', <bang>0)
command! -bang Valet call fzf#vim#files('~/valet-park', <bang>0)
command! -bang Sites call fzf#vim#files('~/sites', <bang>0)
command! -bang Repos call fzf#vim#files('~/repos', <bang>0)
command! -bang Etc call fzf#vim#files('/etc', <bang>0)
" Dotf will not work because VIM will not be able to find shell aliases.
" command! -bang Dotf call fzf#run({'source': 'dfiles ls-files ~', 'sink': 'e'})
command! -bang Dfiles call fzf#run({'source': 'dfl', 'sink': 'e'})

if executable('shfmt')
    " command! -bang ShellFormat :%!shfmt -ln bash -i 2
    command! -bang ShellFormat :ALEFix
endif

" Apply macro to current line or to selection.
command! -nargs=1 -range=% Macro  <line1>,<line2>:norm! @<args>

" Reload last session that is saved by coc-lists
" command! Reload :source ~/.vim/sessions/default.vim

" List yank registers using CocList
command! Y :exe 'CocList registers'

" Read any shell command's output into the current line
command! -nargs=1 Read :0r !<args>

" Run a PHP builtin server in localhost:8080
command! Playground :e ~/sites/pws-playground/public/index.php | :exe 'FloatermNew --title=Playground --silent "./pws"'
command! PHPServer :call PHPServer()

" TODO: Snp command in Floaterm window
" -nargs=1
command! Snp2 :exe 'FloatermNew --title=Snippets s10 <args>'


" Ranger wrapper with floaterm
command! Ranger FloatermNew ranger

command! -nargs=1 -range=% FindAndReplaceLiteral  <line1>,<line2>:!sd --string-mode <args>
" FIXME: Handle args in a function
" command! -nargs=1 -range=% FindAndReplaceExact  <line1>,<line2>:!sd --string-mode <args>

" Select from available filetypes
" FZF already provides 'Filetypes'
" command! Filetype :exe 'CocList filetypes'

" Run current buffer as Perl code
command! RunPerl :w !perl
command! NewPerl :call ScratchPERL()

" Run current buffer as Lua code
" command! RunLua :w !lua
" command! RunLua :w !$HOME/luajit21/bin/luajit
" command! RunLua :lcd %:h | w !$HOME/luajit21/bin/luajit
command! RunLua :lcd %:h | !clear;$HOME/luajit21/bin/luajit %
command! NewLua :call ScratchLUA()

" Run current buffer as PHP code
" Command abbreviation: rh
" ATTENTION: Depends on current working directory
" command! RunPHP :w !phpo
" This handles the working directory problem
" command! RunPHP :lcd %:h | w !phpo
command! RunPHP :!clear;phpo %
" command! RunPHP :up | w !phpo
" Command abbreviation: nh
command! NewPHP :call ScratchPHP()


" Run current buffer as C code with tcc
command! RunC :lcd %:h | !clear;/usr/bin/tcc -run %
command! NewC :call ScratchC()

" There is :rc command abbreviation for this command
" in abbreviations.vimrc
command! RunCargo :w | !clear && cargo run --quiet
" Run current buffer as single file rust script.
" Requires rust-nightly.
" There is :rs command abbreviation for this command
" in abbreviations.vimrc
command! RunRust :silent! call RunRustScript()
" Create a new rust single file buffer
command! NewRust :call ScratchRUST()

" Below one runs like the rust version, in a floaterm
" command! RunVLang :silent! call RunVLangScript()
command! RunVLang :w !v
" Create a new vlang single file buffer
command! NewVLang :call ScratchVLang()

command! RunGolang :w !go run %
" Create a new Golang single file buffer
command! NewGolang :call ScratchGolang()

" Some closed buffers will come back when you restore a session
" even you closed them with bd
" Use BW instead
command! -nargs=? -bang BW :silent! argd % | bw<bang><args>

" Delete file from filesystem and remove the buffer
" Command abbreviation: RM
" command! RemoveFileAndBuffer  :call delete(expand('%')) | bdelete!
command! RemoveFileAndBuffer  :call system('rip --graveyard ~/.local/share/Trash/rip ' . expand('%')) | bdelete!

" Open the last file downloaded in ~/Downloads
command! Last let file = system('last $HOME/Downloads') | :execute ':e '. file

" Replicate gn mapping in lf as a command in vim
command! GN :call system('kitty @ --to unix:/tmp/mykitty launch --type window --cwd "${PWD}"')

" Puts every word to a new line
command! -range=% SpaceToNewline <line1>,<line2>:s/\s\+/\r/
command! -range=% RemoveBlankLines <line1>,<line2>:g/^$/d

command! -bang SnpNew let tmpfile = system('snippet-writer-v new') | :execute ':e ' . tmpfile | setf toml | :norm vin'
command! -bang SnpSyn :call fzf#run({'source': 'snippet-writer-v syn', 'sink': funcref('HandleSnpSyn')})
command! -bang SnpParent :call fzf#run({'source': 'snippet-writer-v categories', 'sink': funcref('HandleSnpParent')})
command! -bang SnpSave :call HandleSnpSave()

" Display 1m system load average
command! -bang Lavg :echo LoadAvg()
