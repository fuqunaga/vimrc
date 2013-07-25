
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" --------------------------------------------------------------------------------
" --- neobundle.vim - プラグインの集中管理
" --------------------------------------------------------------------------------
set nocompatible
filetype off

if has("vim_starting")
set rtp+=$VIM/bundle/neobundle.vim/
call neobundle#rc(expand('$VIM/bundle'))
endif 

" original repos on github
" https だとつながらなかったので明示的にhttpで指定
NeoBundle 'http://github.com/Shougo/unite.vim'
" NeoBundle 'http://github.com/Shougo/vimshell'
NeoBundle 'http://github.com/Shougo/neocomplcache'
" NeoBundle 'http://github.com/ujihisa/quickrun'
" NeoBundle 'http://github.com/thinca/vim-ref'
NeoBundle 'http://github.com/vim-ruby/vim-ruby'
NeoBundle 'http://github.com/vim-scripts/surround.vim'
NeoBundle 'http://github.com/vim-scripts/grep.vim'
NeoBundle 'http://github.com/h1mesuke/vim-alignta'
" NeoBundle 'http://github.com/othree/eregex.vim'
NeoBundle 'http://github.com/kana/vim-altr'
" NeoBundle 'http://github.com/companygardener/perforce.vim'
NeoBundle 'http://github.com/vim-scripts/gtags.vim'
NeoBundle 'http://github.com/tpope/vim-fugitive'
NeoBundle 'http://github.com/gregsexton/gitv'
NeoBundle 'http://github.com/kien/ctrlp.vim'

filetype plugin indent on
"--------------------------------------------------------------------------------


" --------------------------------------------------------------------------------
" --- unit.vim - 
" --------------------------------------------------------------------------------
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

let g:unite_source_file_mru_limit = 10

" インサート／ノーマルどちらからでも呼び出せるようにキーマップ
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction
" --------------------------------------------------------------------------------

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis

set nu

" 文字を回り込ませない
set nowrap


"コメント行で改行すると次の行の先頭に自動的にコメント記号が入らないように
"set formatoptions-=ro


" QuickFix
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>
nnoremap <C-q> <C-w><C-w><C-w>q

" タグジャンプ
nnoremap <C-F10> :tn<CR>
nnoremap <C-F11> :tp<CR>


" CTRL-A で8進数の計算をさせない
set nrformats=alpha

" for cygwin
" http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/vim_faq_help.html
" set shellcmdflag=-ic
" set shellquote=
" set shellslash          " 展開に(バックスラッシュでなく)スラッシュを使う
" set shellxquote=\"
" set shell=c:\cygwin\bin\bash.exe " bashをシェルに使う
" set shellpipe=2>&1\|\ tee
" set shellredir=>%s\ 2>&1

" for make
" make の前にロケールを消しとく
"set makeprg=LANG=\ m
"set makeef=../mef##.tmp
"
"" make エラーフォーマット
"set errorformat=%E%*\\sError\ :\ (%n)%m,
"				\%E%*\\sError\ :\ %m,
"                \%W%*\\sWarning\ :\ (%n)%m,
"			    \%+C%*\\s%m,
"			    \%Z%f\ line\ %l%m,
"			    \%f\ line\ %l%m,
"			    \%*\\sStatus\ :\ %m
"
"noremap <F5> :!start bash -ic "make run Target=Debug"<CR>
"noremap <S-F5> :silent! !ndstop<CR>
"noremap <F6> :make Target=Debug<CR>
"noremap <F7> :!start bash -ic "make run Target=Profile"<CR>
"noremap <F8> :make Target=Profile<CR>


" インデント
set tabstop=4
set shiftwidth=4
set cinoptions+=(0,g2,h2

" バッファ放棄時は隠すだけ
set hid

" ステータスラインに文字コードと改行文字を表示する 
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P


" マッチしたファイル名全てを表示する
" だけで、最初の候補を補完しないようにするには？
" http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/vim_faq_help.html
set wildmode=list:longest 


" yankring.vim
" 起動時の警告メッセジーを消す
" http://d.hatena.ne.jp/seiunsky/20080517/1211051041
set viminfo+=!

" --------------------------------------------------------------------------------
" --- grep.vim
" --------------------------------------------------------------------------------
let Grep_Path               = 'c:\cygwin\bin\grep.exe'
let Fgrep_Path              = 'c:\cygwin\bin\fgrep.exe'
let Egrep_Path              = 'c:\cygwin\bin\egrep.exe'
let Grep_Find_Path          = 'c:\cygwin\bin\find.exe'
let Grep_Xargs_Path         = 'c:\cygwin\bin\xargs.exe'
" let Grep_Default_Filelist   = '*.h *.c *.cpp *.inl *.cxx'
let Grep_Shell_Quote_Char = "'"
let Grep_Shell_Escape_Char  = '\'
let Grep_Skip_Dirs          = '.svn *~'

let Grep_Cygwin_Find        = 1
let $CYGWIN = 'nodosfilewarning'
" --------------------------------------------------------------------------------

" --------------------------------------------------------------------------------
" --- neocomplcache.vim
" --------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスファイルの補完対象キーワードとする最小の長さ
let g:NeoComplCache_MinSyntaxLength = 3
" プラグイン毎の補完関数を呼び出す文字数
let g:NeoComplCache_PluginCompletionLength = {
  \ 'keyword_complete'  : 2,
  \ 'syntax_complete'   : 2
  \ }

" --------------------------------------------------------------------------------
" --- vim-altr
" --------------------------------------------------------------------------------
call altr#define('%.h', '%.cpp', '%.cc', '%_sp.php', '%_mb.php', '%_sp.tpl', '%_mb.tpl', 'controllers/%.php', 'models/model_%.php', 'libraries/*/logic/%_logic.php')
nmap <F2>  <Plug>(altr-forward)


" --------------------------------------------------------------------------------
" --- gtags
" --------------------------------------------------------------------------------
nnoremap <C-j> :GtagsCursor<CR>

" --------------------------------------------------------------------------------
" --- その他
" --------------------------------------------------------------------------------
map <C-F12> :!start gtags<CR>

"set completeopt=menu,longest


set fileformats=unix,dos,mac

