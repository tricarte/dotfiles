" increment decrement numbers
nnoremap + <C-a>
nnoremap - <C-x>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" OK, this mappings causes both vim-searchindex or the native functionality
" not work.
" nnoremap n nzzzv
" nnoremap N Nzzzv

nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" grep.vim
" nnoremap <silent> <leader>f :Rgrep<CR>
" let Grep_Default_Options = '-IR'
" let Grep_Skip_Files = '*.log *.db'
" let Grep_Skip_Dirs = '.git node_modules'

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
" noremap <Leader>h :<C-u>split<CR>
" noremap <Leader>v :<C-u>vsplit<CR>

"" Git
" noremap <Leader>ga :Gwrite<CR>
" noremap <Leader>gc :Gcommit<CR>
" noremap <Leader>gsh :Gpush<CR>
" noremap <Leader>gll :Gpull<CR>
" noremap <Leader>gs :Gstatus<CR>
" noremap <Leader>gb :Gblame<CR>
" noremap <Leader>gd :Gvdiff<CR>
" noremap <Leader>gr :Gremove<CR>

" session management
" nnoremap <leader>so :OpenSession<Space>
" nnoremap <leader>ss :SaveSession<Space>
" nnoremap <leader>sd :DeleteSession<CR>
" nnoremap <leader>sc :CloseSession<CR>

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" nnoremap <silent> <S-t> :tabnew<CR>

" Set working directory
" auto change directory to match current file
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

"" Opens an edit command with the path of the currently edited file filled in
" noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
" noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>

" Voom Outliner
nmap <silent> <F8> :VoomToggle<CR>

" noremap YY "+y<CR>
" noremap <leader>p "+gP<CR>
" noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Copy/Paste/Cut
if has('unnamedplus')
    vnoremap <c-x> "+d
    vnoremap <c-v> "+p
    imap <c-v> <esc>"+p0gv<esc>0
    vnoremap <c-c> "+y
endif


" if has('unnamedplus')
"   " pbcopy for OSX copy/paste
"   vmap <C-x> :!pbcopy<CR>
"   vmap <C-c> :w !pbcopy<CR><CR>
" endif

"" Buffer nav
" noremap <leader>z :bp<CR>
" noremap <leader>q :bp<CR>
" noremap <leader>x :bn<CR>
" noremap <leader>w :bn<CR>

" use bufkill instead of default :bd
" nnoremap <leader>bd :BD!<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" split line
" Disabled. Use r<CR> or s<CR>. s<CR> will get you in 'INSERT' mode.
" nnoremap K i<CR><Esc>

" go to the beginning of the line
" nnoremap H 0
" go the end of the line
" nnoremap L $

" fast saves
nnoremap <leader>w :w!<cr>

" shortcut to startify
nnoremap <leader>st :Startify<cr>

" easy escaping to normal mode
inoremap jj <esc>
inoremap JJ <esc>

" Easier window navigation
" Right now these dont work because of the next mappings
" nnoremap <c-h> <c-w>h
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-l> <c-w>l

" Move between buffers
" nnoremap <c-h> :bp<cr>
" nnoremap <c-l> :bn<cr>
" https://vi.stackexchange.com/questions/19405/skip-the-quickfix-list-when-buffer-switching-using-bn
function! BSkipQuickFix(command)
  let start_buffer = bufnr('%')
  execute a:command
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    execute a:command
  endwhile
endfunction

nnoremap <c-l> :call BSkipQuickFix("bn")<CR>
nnoremap <c-h> :call BSkipQuickFix("bp")<CR>

" resize vsplit
" no need for the below mapping, as arrow keys do this
" nnoremap <c-v> :vertical resize +5<cr>
nnoremap 25 :vertical resize 40<cr>
nnoremap 50 <c-w>=
nnoremap 75 :vertical resize 120<cr>

" Switch to previous buffer, think of it as [ a ]lt + [ t ]ab
nnoremap <leader>at <c-^>

" " All things CtrlP
" nnoremap <c-p>b :CtrlPBuffer<cr>
" nnoremap <c-p>m :CtrlPMRUFiles<cr>
" nnoremap <c-p>p :CtrlPMixed<cr>
" nnoremap <c-p>w :CtrlPCurWD<cr>
" nnoremap <c-p>f :CtrlPCurFile<cr>
" nnoremap <c-p>c :CtrlPCmdPalette<cr>
" nnoremap <c-p>cc :CtrlPClearCache<cr>
" nnoremap <c-p>t :CtrlPTag<cr>
" " meaning symbols for current file
" nnoremap <c-p>s :CtrlPBufTag<cr>
" " function definitions
" nnoremap <c-p>fd :CtrlPFunky<cr>
" " fuzzy search in current files using lines
" nnoremap <c-p>l :CtrlPLine<cr>

" All things FZF
nnoremap <c-p>b :Buffers<cr>
nnoremap <c-p>m :History<cr>
nnoremap <c-p>w :GFiles<cr>
nnoremap <c-p>f :Files<cr>
nnoremap <c-p>c :Commands<cr>
" Tags and BTags are not LanguageServer aware.
" They are just using the tags file.
nnoremap <c-p>t :Tags<cr>
" Same as Tags but for current buffer only
nnoremap <c-p>s :BTags<cr>
nnoremap <c-p>l :Lines<cr>
nnoremap <c-p>$ :Floaterms<cr>

" http://code.tutsplus.com/articles/top-10-pitfalls-when-switching-to-vim--net-18113
" shortcut to fold tags with leader
" nnoremap <leader>ft vatzf

" visually reselect the text that was last edited/pasted
nnoremap gv `[v`]

" Move visual block (bubble)
" You'd better change the mapping because joining lines
" may be used the most.
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" These are useful when exiting curly braces, quotes, parens, etc in insert mode.
" jumps to the next position after the closest closing char
inoremap <leader>e <Esc>/[\]})"'`]<cr><Esc>:nohlsearch<cr>a
" exit the closest closing char and put a comma
inoremap <leader>ee <Esc>/[\]})"'`]<cr><Esc>:nohlsearch<cr>A;
inoremap <leader>e, <Esc>/[\]})"'`]<cr><Esc>:nohlsearch<cr>a,<Space>
" inoremap <leader>eb <Esc>/[\]})"']<cr><Esc>:nohlsearch<cr>a<Space>{}<C-o>i<CR><Esc>O

" window resize mappings (ctrl + arrow key)
nnoremap <Up> <c-w>+
nnoremap <Down> <c-w>-
nnoremap <Left> <c-w><
nnoremap <Right> <c-w>>

" wrap selection inside character
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ` "zdi`<C-R>z`<ESC>

" paste from system clipboard as in termimal
" if has("gui_running")
"     inoremap <C-V> <C-o>"+gP
" endif

" Clean highlight after search
noremap  <silent>// :nohlsearch<CR>

" map enter and backspace to go next and previous paragraph
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {

nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }

"" Open current line on GitHub
" nnoremap <Leader>o :.Gbrowse<CR>

" https://www.reddit.com/r/vim/comments/8xib46/display_the_enclosing_functionclasstag_you_are_on/
" To use this function
" :Whereami
function! DisplayEnclosingLine()
  let cmd = "ctags -f - --fields=n " . expand('%') . " | awk -F: '{ print $NF }'"
  let cmd .= " | sort -nr | awk '" . line('.') . " >= $1 { print $1; exit }' "
  let linenum = system(cmd)
  let line = substitute(getline(linenum), '^\s*', '', 'g')
  echo line
endfunction

" Avoid arrow keys in command mode
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
cnoremap <C-x> <del>

" Browse home
cnoremap eh e ~/

" Close buffer
nnoremap <leader>q :bd<CR>
" " Using bbye plugin
" " This removes the close file from jump list.
" nnoremap <leader>q :Bwipeout<CR>

" View git log history for current file.
" https://www.reddit.com/r/vim/comments/8w3udw/topnotch_vim_file_backup_history_with_no_plugins/
" This opens up a new tmux window.
noremap <silent> <leader>obk :call OpenCurrentFileBackupHistory()<cr>

" mucomplete complete with previous expansion.
" While mucomplete shows completion list press right arrow key.
imap <expr> <right> mucomplete#extend_fwd("\<right>")
imap <expr> <left> mucomplete#extend_bwd("\<left>")

" goto next and previous diffs
nmap <leader>dj ]c
nmap <leader>dk [c

" Make word before cursor uppercase in insert mode.
inoremap <leader>U <c-o>g~iw<esc>ea

" Fuzzy search in WordPress tags from dictionary files.
augroup WPFuzzy
    autocmd!
    autocmd FileType php inoremap <leader>wp <c-o>:call fzf#vim#complete('cat ~/.vim/dict/vim-dict-wordpress/*.dict')<cr>
augroup END

" Disable line splitting in PHP files.
" augroup PHPManual
"     autocmd!
"     autocmd FileType php silent! nunmap <S-k>
" augroup END

if executable("piknik")
    command! Pkp :r!piknik -paste
    command! -range Pkc :silent '<,'>w !piknik -copy
endif

nnoremap <leader>sn :Snippets<CR>

" Do an exact whole word search using /\<keyword\>
nnoremap <leader>/ /\<\><left><left>

" bufferline plugin provides mappings for switching by ordinal buffer numbers
nnoremap <Leader>1 <Plug>lightline#bufferline#go(1)
nnoremap <Leader>2 <Plug>lightline#bufferline#go(2)
nnoremap <Leader>3 <Plug>lightline#bufferline#go(3)
nnoremap <Leader>4 <Plug>lightline#bufferline#go(4)
nnoremap <Leader>5 <Plug>lightline#bufferline#go(5)
nnoremap <Leader>6 <Plug>lightline#bufferline#go(6)
nnoremap <Leader>7 <Plug>lightline#bufferline#go(7)
nnoremap <Leader>8 <Plug>lightline#bufferline#go(8)
nnoremap <Leader>9 <Plug>lightline#bufferline#go(9)
nnoremap <Leader>0 <Plug>lightline#bufferline#go(10)
" nnoremap <Leader>1 :b1<cr>
" nnoremap <Leader>2 :b2<cr>
" nnoremap <Leader>3 :b3<cr>
" nnoremap <Leader>4 :b4<cr>
" nnoremap <Leader>5 :b5<cr>
" nnoremap <Leader>6 :b6<cr>
" nnoremap <Leader>7 :b7<cr>
" nnoremap <Leader>8 :b8<cr>
" nnoremap <Leader>9 :b9<cr>
" nnoremap <Leader>0 :b0<cr>

" floaterm mappings
" nnoremap   <silent>   <space>r :FloatermNew ranger<CR>
" nnoremap   <silent>   <space>r :FloatermNew lf -command 'set nopreview'<CR>
let g:lf_map_keys = 0 " By default, lf.vim uses <leader>f
" Below setting applies <leader>q to everywhere, not just the terminal
" let g:floaterm_keymap_kill = '<leader>q'
nnoremap   <silent>   <space>r :Lf<CR>
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

" Jump between folds
nnoremap <C-j> zj
nnoremap <C-k> zk

" On each invoke, in insert mode, fix the last misspelled word
" using the first result from correction list (z=)
" Spell must be enabled using:
" :set spell
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
