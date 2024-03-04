" Slime config
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "4"}


" Using coc-snippets
" " UltiSnips config
" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" Gutentags config
" Where to store tag files
" Have a look at ~/.ctags file.
" It prevents tagging PHP variables
let g:gutentags_cache_dir = '~/.vim/gutentags'
" put a .notags file inside a git repo to prevent indexing for HOME dir.
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
" let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
"                             \ '*.phar', '*.ini', '*.rst', '*.md',
"                             \ '*vendor/*/test*', '*vendor/*/Test*',
"                             \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
"                             \ '*var/cache*', '*var/log*', '~/.vim']
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git', 'composer.json']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" tagbar
let g:tagbar_phpctags_bin='~/bin/phpctags'
let g:tagbar_type_css = {
    \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }
let g:tagbar_autofocus = 1
let g:tagbar_type_json = {
    \ 'ctagstype' : 'json',
    \ 'kinds' : [
      \ 'o:objects',
      \ 'a:arrays',
      \ 'n:numbers',
      \ 's:strings',
      \ 'b:booleans',
      \ 'z:nulls'
    \ ],
  \ 'sro' : '.',
    \ 'scope2kind': {
    \ 'object': 'o',
      \ 'array': 'a',
      \ 'number': 'n',
      \ 'string': 's',
      \ 'boolean': 'b',
      \ 'null': 'z'
    \ },
    \ 'kind2scope': {
    \ 'o': 'object',
      \ 'a': 'array',
      \ 'n': 'number',
      \ 's': 'string',
      \ 'b': 'boolean',
      \ 'z': 'null'
    \ },
    \ 'sort' : 0
    \ }

" vista.vim - tagbar alternative
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_sidebar_width = 50
let g:vista_close_on_jump = 1
let g:vista_executive_for = {
            \ 'markdown': 'toc',
            \ }

let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ 'it'  :1,
      \ }

" rooter config
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', '.git/', '.root', '.htaccess']
let g:rooter_silent_chdir = 1

" CtrlP config
set wildignore+=/.git/,/.hg/,/.svn/
" let g:ctrlp_buftag_ctags_bin = '~/bin/phpctags'
" let g:ctrlp_buftag_ctags_bin = '~/bin/bin/ctags'
let g:ctrlp_extensions = ['tag', 'buffertag', 'mixed', 'line']
let g:ctrlp_buftag_types = {
            \ 'php' : {
                \ 'bin' : '~/bin/phpctags',
                \ 'args' : '--kinds=cmfpditn -f -',
            \ },
            \ }
let g:ctrlp_custom_ignore = {
 \ 'dir':  'node_modules\|ds_store\|git\|bower_components\|vendor',
 \ 'file': '\v\.(exe|so|dll)$',
 \ }
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag %s -l -f --hidden --nocolor -g ""'

" Airline config
" let g:airline_powerline_fonts = 1
" enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" show just the filename and buffer number
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline_section_c = '%F'
" let g:airline_theme='solarized'

" syntastic config (also includes config of ale plugin)
" These 4 lines are set in ~/.vim/vimrc
" set laststatus=2
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" This disables the window but still shows the errors on line numbers.
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = '/usr/bin/tidy'
let g:syntastic_ignore_files = ['\m\c\.env$']
let g:syntastic_php_checkers = ['php']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_aggregate_errors = 0
let g:syntastic_php_phpcs_args = "--standard=psr2"
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" if you prefer to use ale
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 1
let g:ale_open_list = 0
let g:ale_lint_on_save = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
" let g:ale_virtualtext_cursor = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_list_window_size = 5
let g:ale_echo_cursor = 1
" let g:ale_change_sign_column_color = 1
let g:ale_sign_error = '✗'
" let g:ale_sign_error = 'X'
let g:ale_sign_warning = '⚠'
let g:ale_disable_lsp = 1
" Linters are syntax error and best practices checkers.
" Fixers are anything that changes the code including beautifying.
let g:ale_linters = {'php': ['php'], 'html': [], 'css': [], 'typescriptreact': [], "javascript": [], 'perl': ['perl', 'perlcritic']}
let g:ale_fixers = { 'php': [ 'phpcbf', 'php_cs_fixer'], 'html': ['prettier'], 'css': ['prettier'], 'sh': ['shfmt'], 'perl': ['perltidy'], 'rust': ['rustfmt'] }
let g:ale_sh_shfmt_options = '-ln bash -i 2'
let g:ale_perl_perl_options = '-c'

let g:prettier#config#tab_width = 2

" Sprint config
let g:SprintHidden = 0

" VDebug config
let g:vdebug_options = {
            \ "port": 9000,
            \ "server": '192.168.1.10',
            \ 'path_maps': {'/shared/httpd/mywp/mywp': '~/repos/devilbox/data/www/mywp/mywp'},
            \ }

" NerdTree config
let NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let g:nerdtree_tabs_open_on_gui_startup=0

" Ags config
let g:ags_agargs = {
            \ '--break'             : [ '', '' ],
            \ '--color'             : [ '', '' ],
            \ '--color-line-number' : [ '"1;30"', '' ],
            \ '--color-match'       : [ '"32;40"', '' ],
            \ '--color-path'        : [ '"1;31"', '' ],
            \ '--column'            : [ '', '' ],
            \ '--context'           : [ 'g:ags_agcontext', '-C', '3' ],
            \ '--group'             : [ '', '' ],
            \ '--smart-case'        : [ '', '' ],
            \ '--hidden'            : [ '', '' ],
            \ '--heading'           : [ '', '-H' ],
            \ '--max-count'         : [ 'g:ags_agmaxcount', '-m', '2000' ]
            \ }

" Startify config
"let g:startify_change_to_dir = 0
" let g:startify_custom_header = 'startify#fortune#quote()'
let g:startify_custom_header =[]
let g:startify_change_to_vcs_root = 1
"let g:startify_custom_footer='b -> open in same window, s -> open in horizontal split, v -> open in vertical split'
let g:startify_bookmarks=['~/.vim/vimrc',
            \ '~/.bash_aliases',
            \ '~/.bash_functions',
            \ '~/.bashrc',
            \ '~/.tmux.conf',
            \ '/etc/mysql/my.cnf',
            \ '/etc/nginx/nginx.conf',
            \ '/etc/ssh/sshd_config',
            \ '/etc/fail2ban/fail2ban.conf',
            \ '/etc/fail2ban/jail.local',
            \ '/etc/php/7.4/fpm/php.ini',
            \ '/etc/php/7.4/fpm/php-fpm.conf',
            \ '/etc/php/7.4/fpm/conf.d/10-opcache.ini',
            \ '/etc/php/7.4/fpm/pool.d/www.conf',
            \ '/etc/php/7.4/fpm/pool.d/kbdev.conf',
            \ '/etc/ssmtp/ssmtp.conf',
            \ '/etc/ssmtp/revaliases',
            \ '/etc/adduser.conf',
            \ '/etc/deluser.conf',
            \ '/etc/environment',
            \ '/etc/fstab',
            \ '/etc/goaccess.conf',
            \ '/etc/hostname',
            \ '/etc/hosts',
            \ '/etc/ip-blacklist.conf',
            \ '/usr/local/bin/ip-blacklist-load',
            \ '/usr/local/bin/update-blacklist.sh',
            \ '/usr/local/bin/check-update.sh',
            \ '/etc/lsb-release',
            \ '/etc/mongod.conf',
            \ '/etc/passwd',
            \ '/etc/resolv.conf',
            \ '/etc/network/interfaces',
            \ '/etc/securetty',
            \ '/etc/services',
            \ '/etc/sysctl.conf',
            \ '/etc/timezone',
            \ '/etc/vnstat.conf']


" closetag configuration
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.js"

" manpager configuration
let g:ft_man_open_mode = 'vert'

" Using coc.nvim for completion
" " mucomplete configuration
" " set completeopt+=longest
" set completeopt+=menuone " menuone is working
" set completeopt+=noselect
" set completeopt+=noinsert
" set shortmess+=c   " Shut off completion messages
" set belloff+=ctrlg " If Vim beeps during completion
" let g:mucomplete#enable_auto_at_startup = 1
" set completeopt-=preview
" let g:mucomplete#cycle_all = 0
" let g:mucomplete#chains = {}
" let g:mucomplete#ultisnips#match_at_start = 1
" let g:mucomplete#always_use_completeopt = 1
" " let g:mucomplete#chains.default  = [ 'keyp', 'ulti', 'omni', 'path', 'dict' ]
" let g:mucomplete#chains.default  = [ 'keyp', 'ulti', 'path', 'dict' ]
" let g:mucomplete#chains.php  = [ 'omni', 'ulti', 'keyp', 'dict', 'path' ]
" let g:mucomplete#chains.html  = [ 'ulti', 'path' ]
" let g:mucomplete#chains.css  = [ 'omni', 'ulti', 'keyp' ]
" let g:mucomplete#chains['javascript.jsx']  = [ 'ulti', 'keyp' ]
" " let g:mucomplete#chains.default  = ['omni']
" " let g:mucomplete#chains.default  = ['keyn', 'ulti', 'c-n', 'omni', 'path']


" wordpress.vim configuration
let g:wordpress_vim_php_syntax_highlight = 0
let g:wordpress_vim_readme_auto_validator = 0
let g:wordpress_vim_jump_to_core_mappings = 1
let g:wordpress_vim_php_syntax_highlight = 0

" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs' " options: --config
" End of php-cs-fixer version 2 config params

" let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 0     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" Echodoc
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'popup'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Php-Namespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"""""""""""""""""""""""""""""
"  faker additional fakers  "
"""""""""""""""""""""""""""""
"" Choose a random element from a list
call fake#define('sex', 'fake#choice(["male", "female"])')

"" Get a name of male or female
"" fake#int(1) returns 0 or 1
call fake#define('name', 'fake#int(1) ? fake#gen("male_name")'
                                  \ . ' : fake#gen("female_name")')

"" Get a full name
call fake#define('fullname', 'fake#gen("name") . " " . fake#gen("surname")')

"" Get a nonsense text like Lorem ipsum
call fake#define('sentense', 'fake#capitalize('
                        \ . 'join(map(range(fake#int(3,15)),"fake#gen(\"nonsense\")"))'
                        \ . ' . fake#chars(1,"..............!?"))')

call fake#define('paragraph', 'join(map(range(fake#int(3,10)),"fake#gen(\"sentense\")"))')

"" Alias
call fake#define('lipsum', 'fake#gen("paragraph")')

" cht.sh
let  g:CheatSheetProviders = ['quickfix']

" far.vim source
let g:far#source = 'ag'

let g:phpcd_php_cli_executable = 'php7.4'


" Disable <c-h> for I'm using it for switching to left buffer.
let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip" 
let g:php_manual_online_search_shortcut = ''

let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'php', 'tsx']

" FZF Config
" let g:fzf_preview_window = ['right:50%', 'ctrl-/']
" let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
let g:fzf_preview_window = []
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

let g:doge_enable_mappings = 0
let g:doge_buffer_mappings = 1
" let g:doge_php_settings = {
" \  'resolve_fqn': 1
" \}

" floaterm settings
let g:floaterm_width = 0.8
let g:floaterm_position = 'bottom'
let g:floaterm_height = 0.8
let g:floaterm_autoclose = 2
let g:floaterm_opener = 'edit'
hi FloatermBorder guifg=orange

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_setColors = 0
" let g:indentLine_concealcursor = 0
" let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" vim-bufferline
" let g:bufferline_echo = 0
" autocmd VimEnter *
"             \ let &statusline='%{bufferline#refresh_status()}'
"             \ .bufferline#get_status_string()

" Default is float window, but other plugins that create floats will get below
" let g:context_presenter = 'preview'
let g:context_enabled = 0

" lf.vim
" open lf instead of netrw
" let g:NERDTreeHijackNetrw = 0
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
