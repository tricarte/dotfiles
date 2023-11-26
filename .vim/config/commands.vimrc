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
command! -bang Dotf call fzf#run({'source': 'dotfiles ls-files ~', 'sink': 'e'})

if executable('shfmt')
    " command! -bang ShellFormat :%!shfmt -ln bash -i 2
    command! -bang ShellFormat :ALEFix
endif

" Apply macro to current line or to selection.
command! -nargs=1 -range=% Macro  <line1>,<line2>:norm! @<args>

" Reload last session that is saved by coc-lists
command! Reload :source ~/.vim/sessions/default.vim

" List yank registers using CocList
command! Y :exe 'CocList registers'

" Read any shell command's output into the current line
command! -nargs=1 Read :0r !<args>

" TODO: Can we handle calling multiple times?
" Run a PHP builtin server in localhost:8080
command! Playground :e ~/sites/pws-playground/public/index.php | :exe 'FloatermNew --title=Playground --silent "./pws"'

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
command! RP :w !perl
" command! RP :w !perl -w
" command! NP :enew!|setlocal filetype=perl
command! NP :call Scratch()
