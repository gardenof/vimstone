let s:current_filename=expand("<sfile>")
let s:truecolor=($COLORTERM == "truecolor")

if s:truecolor
  set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'commit': '6188c5e' }

Plug 'neomake/neomake', { 'commit': '4cc1462' }

Plug 'mileszs/ack.vim', { 'commit': '36e40f9' }

Plug 'flazz/vim-colorschemes', { 'commit': 'eab3157' }

Plug 'kien/ctrlp.vim', { 'commit': '564176f' }

Plug 'neovimhaskell/haskell-vim', { 'commit': 'a5302e0' }

Plug 'raichoo/purescript-vim', { 'commit': 'ab8547ce' }

Plug 'fatih/vim-go', { 'commit': '8575d9e' }

Plug 'ElmCast/elm-vim', { 'commit': 'ae53153' }

Plug 'vmchale/dhall-vim', { 'commit': '77d1c16' }

Plug 'sbdchd/neoformat', { 'commit': '4dba93d' }

Plug 'jreybert/vimagit', { 'commit': '85c25ff' }

Plug 'skwp/greplace.vim', { 'commit': 'a34dff3' }

Plug 'tpope/vim-surround', { 'commit': 'e49d6c2' }

Plug 'tpope/vim-repeat', { 'commit': '8106e14' }

Plug 'gcmt/taboo.vim', { 'commit': '1367baf' }

Plug 'nicwest/vim-http', { 'commit': '99d3edf' }

Plug 'ervandew/supertab', { 'commit': '40fe711' }

Plug 'neoclide/coc.nvim', {'commit': '7642d233d6abdce9c0076629deaacdb59ea75f70'}

Plug 'liuchengxu/vim-which-key', { 'commit': 'c5322b2' }

call plug#end()

syntax on
filetype plugin indent on

"
" Provide a way to reload the vim setup nicely. Vim
" won't let you redefine functions that are currently
" executing, so we have to guard against reloading these.
"
if !exists('s:reloaders_defined')
  let s:reloaders_defined=1

  function! s:SourceInitFile()
    execute ':source '.s:current_filename
  endfunction

  function! s:Reload()
    call s:SourceInitFile()
    PlugInstall
  endfunction

  command! SourceInitFile call s:SourceInitFile()
  command! Reload call s:Reload()
endif

"
" Command to view the git log
"
function! s:GitLog()
  let l:name=bufname('%')
  let l:type=getbufvar('%', '&buftype', 'ERROR')
  let l:basecmd="git --no-pager log --graph"

  if l:type == "" && glob(l:name) != ""
    let l:cmd=l:basecmd." ".l:name
  else
    let l:cmd=l:basecmd
  endif

  split
  resize
  execute "terminal ".l:cmd
  set nomodified
  execute "file git log ".l:name
  noremap <silent> <buffer> q :bdelete!<CR>
endfunction

command! -nargs=0 GitLog call s:GitLog()

"
" Command to view the git blame
"
function! s:GitBlame()
  let l:name=bufname('%')
  let l:cmd="git --no-pager blame ".l:name
  split
  resize
  execute "terminal ".l:cmd
  set nomodified
  execute "file git blame ".l:name
  noremap <silent> <buffer> q :bdelete!<CR>
endfunction

command! -nargs=0 GitBlame call s:GitBlame()

" This is the prefix diction that mappings should add to below to
" customize their appears in the which key menu.
let g:which_key_map =  {}

"

let mapleader=" "

let g:which_key_map.s = { 'name' : '+search' }

let g:which_key_map.s.a = 'search all files in current directory'
noremap <Leader>sa :Ack!<Space>

let g:which_key_map.s.o = 'open search results window (a.k.a. quickfix list)'
noremap <silent> <Leader>so :copen<CR>

let g:which_key_map.s.c = 'close search results window (a.k.a. quickfix list)'
noremap <silent> <Leader>sc :cclose<CR>

let g:which_key_map.s.w = 'search for word under cursor in current directory'
noremap <Leader>sw :Ack! -w '<cword>'<CR>

let g:which_key_map.s.r = 'use search results to do a multi-file replace'
noremap <silent> <Leader>sr :execute ':Gqfopen' <Bar> cclose<CR>

" Special mappings for the quickfix list, because they are
" easier to hit repeatedly without the preceding 'c'
let g:which_key_map.n = 'go to next search result'
noremap <silent> <Leader>n :cnext<CR>

let g:which_key_map.p = 'go to previous search result'
noremap <silent> <Leader>p :cprevious<CR>

let g:which_key_map.t = { 'name' : '+nerdtree' }

let g:which_key_map.t.t = 'toggle display of NERDTree'
noremap <silent> <Leader>tt :NERDTreeToggle<CR>

let g:which_key_map.t.f = 'find current file in the NERDTree window'
noremap <silent> <Leader>tf :NERDTreeFind<CR>

let g:which_key_map.a = 'Open file using fuzzy finder'
noremap <silent> <Leader>a :CtrlP<CR>

let g:which_key_map.g = { 'name' : '+git' }

let g:which_key_map.g.s = 'stage changes for commit with Magit'
let g:which_key_map.M = g:which_key_map.g.s " vim magit installs a default binding
noremap <silent> <Leader>gs :Magit<CR>

let g:which_key_map.g.l = 'git-log the current file'
noremap <silent> <Leader>gl :GitLog<CR>

let g:which_key_map.g.b = 'git-blame the current file'
noremap <silent> <Leader>gb :GitBlame<CR>

" Switch to alternate (previous) buffer in a window. See
" :help alternate
let g:which_key_map["<Tab>"] = "Switch between currenta and alternate buffer"
noremap <silent> <Leader><Tab> :buffer #<CR>

let g:which_key_map.w = { 'name' : '+window' }

let g:which_key_map.w.c = "Close the current wndow"
noremap <silent> <Leader>wc <C-w>c

let g:which_key_map.w.o = "'Only' the current wndow (close all others)"
noremap <silent> <Leader>wo <C-w>o

let g:which_key_map.w.n = "Open a new blank window"
noremap <silent> <Leader>wn <C-w>n

let g:which_key_map.w.w = "Move cursor to next window"
noremap <silent> <Leader>ww <C-w>w

let g:which_key_map.w.W = "Move cursor to previous window"
noremap <silent> <Leader>wW <C-w>W

let g:which_key_map.w.r = "Rotate windows"
noremap <silent> <Leader>wr <C-w>r

let g:which_key_map.w["="] = "Equalize window sizes"
noremap <silent> <Leader>w= <C-w>=

let g:which_key_map.w.h = "Move cursor one window left"
noremap <silent> <Leader>wh <C-w>h

let g:which_key_map.w.j = "Move cursor one window down"
noremap <silent> <Leader>wj <C-w>j

let g:which_key_map.w.k = "Move cursor one window up"
noremap <silent> <Leader>wk <C-w>k

let g:which_key_map.w.l = "Move cursor one window right"
noremap <silent> <Leader>wl <C-w>l

let g:which_key_map.w.H = "Move current window all the way left"
noremap <silent> <Leader>wH <C-w>H

let g:which_key_map.w.J = "Move current window all the way down"
noremap <silent> <Leader>wJ <C-w>J

let g:which_key_map.w.K = "Move current window all the way up"
noremap <silent> <Leader>wK <C-w>K

let g:which_key_map.w.L = "Move current window all the way right"
noremap <silent> <Leader>wL <C-w>L

let g:which_key_map.w.s = "Split current window horizontally"
noremap <silent> <Leader>ws <C-w>s

let g:which_key_map.w.v = "Split current window vertically"
noremap <silent> <Leader>wv <C-w>v

let g:which_key_map.w["/"] = "Split current window vertically"
noremap <silent> <Leader>w/ :vsplit<CR>

let g:which_key_map.w["-"] = "Split current window horizontally"
noremap <silent> <Leader>w- :split<CR>

let g:which_key_map.f = { 'name' : '+file' }
let g:which_key_map.f.s = "Save the current file"
noremap <silent> <Leader>fs :write<CR>

let g:which_key_map.f.S = "Save all open files"
noremap <silent> <Leader>fS :wall<CR>

let g:which_key_map.b = { 'name' : '+buffer' }
let g:which_key_map.b.b = "Switch to buffer using fuzzy finder"
noremap <silent> <Leader>bb :CtrlPBuffer<CR>

let g:which_key_map.o = { 'name' : '+organize' }
let g:which_key_map.o.i = "Sort list of terms for Haskell import statement"
" note: this does not sort the type constructors
"  inside a nested parens, for ex. Maybe(Nothing, Just),
"  it treats this as one term.
noremap <silent> <Leader>oi V:s/\v[^(]*\(\zs.*\ze\)/\=join(sort(split(submatch(0), '\v(\([^)]*)@<!\s*,\s*')), ', ')<CR>:noh<CR>

vnoremap <silent> <Leader>js !jq .<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-o> <Esc>

" BEGIN coc.vim related configuration

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Mapping to quickly bring up the coc action menu
let g:which_key_map.c = { 'name' : '+coc.vim' }

let g:which_key_map.c.a = "Open the Coc Actions Menu"
noremap   <silent> <Leader>ca :CocAction<CR>

let g:which_key_map.c.g = "Go to definition"
nmap      <silent> <Leader>cg <Plug>(coc-definition)

let g:which_key_map.c.d = "Show documentation"
nnoremap  <silent> <Leader>cd :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" END coc.vim related configuration


" WhichKey needs to be at the end to pick up the mappings defined above
call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

set timeoutlen=300


" Temporary workaround for tutor links not working when
" debug is not on. We need to find a better solution though ;(
let g:tutor_debug=1

let g:ctrlp_use_caching=0

if executable('rg')
  let g:ctrlp_user_command='rg %s --files --color never --hidden -g !.git'
  let g:ackprg='rg --smart-case --no-heading --vimgrep --sort path --hidden -g !.git'
  let g:ack_apply_qmappings = 1
elseif executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ackprg='ag --smart-case --vimgrep'
endif

let purescript_indent_if = 2

let purescript_indent_case = 2
let purescript_indent_where = 2
let purescript_indent_do = 2

set number
set shiftwidth=2
set tabstop=2
set expandtab
set nowrap
set incsearch
set hlsearch

" if we have inccommand (just neovim right now), enable it so we can see
" live results of :substitute and friends as we type
if exists('&inccommand')
  set inccommand=nosplit
endif

" Enable mouse in all modes. With this (and a reasonable terminal emulator)
" you can scroll, resize windows, click on text, and do lots of other mousey
" things even in the terminal.
set mouse=a

set undofile
set undodir=~/.config/nvim/undodir

" Store backups in a different directory to avoid spamming filesystem
" events inside projects
set backupdir=~/.config/nvim/backup

" Use original vim backup behavior to avoid spurious 4913 files (and
" associated events) that come from the default 'auto' behavior.
" This is slightly slower to write, see :help backupcopy for more
" info about the tradeoff being made here. Set this to 'auto' for a hack
" that will let filesystem events by detected by haskell tools inside dockerd
" from OSX, until the fixed fsnotify has permeated the world.
set backupcopy=yes

function! s:ColorOverrides()
  " Darken the background a bit from the Jellybeans default
  highlight Normal guibg=#0e0e0e
  highlight NonText guibg=#0e0e0e

  " Highlight trailing whitepace an the end of lines
  highlight ExtraWhitespace ctermbg=88 guibg=#ee0000

  " Highlight color for highlighting column 80 as a reminder of where to wrap
  " things
  highlight ColorColumn guibg=#0c0c0c

  " Make line numbers a big more visible with a color matching jellybeans
  highlight linenr ctermfg=179 guibg=#0e0e0e guifg=#fad07a
  highlight SignColumn guibg=#0e0e0e

  " Make the status bar and tabline look nicer
  highlight StatusLine ctermbg=238 ctermfg=112 guibg=#1f251f guifg=#b0cc55
  highlight StatusLineNC ctermfg=249 guibg=#202220 guifg=#909090
  highlight VertSplit ctermfg=249 guibg=#0e0e0e guifg=#202220
  highlight TabLine ctermbg=238 ctermfg=249 guibg=#202220 guifg=#909090
  highlight TabLineSel ctermbg=238 ctermfg=112 guibg=#1f251f guifg=#b0cc55

  " Make Coc auto-complete and errors look nicer
  highlight CocFloating guibg=#1f1f1f
  highlight CocErrorFloat ctermfg=1 ctermbg=9 guifg=#EE2222 guibg=#1f1f1f
  highlight CocErrorLine guifg=#EE2222
  highlight Pmenu guibg=#1f1f1f guifg=#70b950
  highlight PmenuSel guibg=#70b950 guifg=#1f1f1f
endfunction

" disable elm-vim's formatting in favor of NeoFormat
let g:elm_format_autosave=0

augroup InitDotVim
  autocmd!

  " Set our color overrides when colorscheme is set
  autocmd ColorScheme * call s:ColorOverrides()

  " Display column for to delineate long lines
  autocmd BufWinEnter * set colorcolumn=80

  " Hack to work around hfsnotify failing to pick up file modified events
  " on linux inside docker by making Vim create a '4913' file in the
  " directory. See comments about backupcopy above.
  autocmd BufWinEnter *.hs setlocal backupcopy=auto

  " Highlight extra whitespace
  autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

  " Workaround for nvim not always calling :set nopaste after paste,
  " which results in :set noexpandtab being turned on globally :(
  au InsertLeave * set nopaste
augroup END

" silent! here suppresses errors about the colorscheme
" missing so that we can run :PluginInstall the first
" time without getting an error.
silent! colorscheme jellybeans

" Make the colors look nicer in the terminal, if supported.
if s:truecolor || has('gui_running')
  " Normal Colors
  let g:terminal_color_0='#000000' " black
  let g:terminal_color_1='#cf6a4c' " red
  let g:terminal_color_2='#99ad6a' " green
  let g:terminal_color_3='#fad07a' " yellow
  let g:terminal_color_4='#7aa6da' " blue
  let g:terminal_color_5='#c397d8' " magenta
  let g:terminal_color_6='#70c0ba' " cyan
  let g:terminal_color_7='#dddddd' " white

  " Bright colors
  let g:terminal_color_8='#666666'  " black
  let g:terminal_color_9='#cc3334'  " red
  let g:terminal_color_10='#9ec400' " green
  let g:terminal_color_11='#e7c547' " yellow
  let g:terminal_color_12='#7aa6da' " blue
  let g:terminal_color_13='#b77ee0' " magenta
  let g:terminal_color_14='#54ced6' " cyan
  let g:terminal_color_15='#ffffff' " white
endif

