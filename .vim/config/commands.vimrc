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
  %!python -mjson.tool
  set syntax=json
endfunction
command! Jsonify :call JSONify()

" make current buffer executable
command! Chmodx :!chmod a+x %

command! Whereami :call DisplayEnclosingLine()

" Format long lines into paragraphs.
command! Format :normal gqip

" Generate docblock.
command! Docblock :call pdv#DocumentWithSnip()<CR>
