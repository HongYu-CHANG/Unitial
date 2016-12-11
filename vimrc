
" charset
set encoding=utf-8          
	"enc(encoding)內部的文字編碼, vim buffer charset, NOT the file's charset
set fileencoding=utf-8      
	"fenc(fileencoding)當前打開的文件編碼, default save charset
set fileencodings=utf-8,big5,gb2312,gb18030,gbk,default  
	"fencs(fileencodings)這是一個字元編碼的列表, default opening charset priority (as auto detection)

" enable features which are not Vi compatible but really really nice.
set nocompatible  
	"nocp 關閉與Vi的相容模式
set nobomb
	" default no bomb for utf-8 移除Bom

" expand TABs to spaces
"set expandtab     
	"et 將tab變成space
"set tabstop=4     
	" set TAB's width 用4個空白鍵取代 Tab
set shiftwidth=4  
	"sw 針對程式縮排所需要的 Space 個數

" use the indent of the previous line for a newly created line
set autoindent    
	"ai 自動縮排

" 256 color mode
set t_Co=256 
	"設定 Vim 支援 256 色

set ruler  
	"ru 是否顯示右下角一些狀態列說明
set number "nu
	" show line numbers

"search relatived
set incsearch     "is
	" show the search results before stop typing 加強式尋找功能，在鍵入 patern 時會立即反應移動至目前鍵入之patern 上
set hlsearch      "hls
	" highlight search results
set ignorecase    "ic
	" case-insensitive search 不區分大小寫的搜尋
set smartcase     "scs
	" smart search (override 'ic' when pattern has uppers)

set backspace=2   "bs
	" enable backspace in insert mode

" file formats priority when try to read a file
set fileformats=unix,dos,mac "ffs 
	"可指定多個，會依載入的檔案形式來調整

" indicates a fast terminal connection
set ttyfast "tf????

" don't redrawnscreen  while executing macros, registers and other commands
set lazyredraw 
	"lz 對於慢終端(slow terminal)我們可以使用lazyredraw選項.他可以阻止Vim在重繪螢幕

" enable window title
set title

" set windows title back to path instead of default 'Thanks for Flying Vim'
let &titleold=getcwd()
	"Adding this line to your vimrc will make Vim put the current working directory in the title

" set statusbar
set statusline+=%f              "filename
set statusline+=%m              "modified flag
set statusline+=%r              "read only flag
set statusline+=\ \%y           "filetype
set statusline+=%=              "left/right separator
set statusline+=%#warningmsg#   "show the errors/warning in the status line
set statusline+=%h              "help file flag
set statusline+=%*              "color off
set statusline+=\ [%{&ff}\]\    "fileformat (unix, dos, mac ...)
set statusline+=%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"} "file charset
set statusline+=[%l,%c]         "cursor line,column
set statusline+=\ \[%L\ lines\] "total lines
set statusline+=\ [%P]          "percent through file
set statusline+=\ %a            "if open multiple files, show current file and and the number of all files

" display a status line at the bottom of the window
set laststatus=2 
	"ls 狀態欄有幾欄

" show as much as possible of the last line, instead of '@' symbol
set display+=lastline
	"when I have a line that can not be entirely shown on screen, the line appears as an at symbol "@" all the way down to the bottom of the screen

" set code folding feature
set foldmethod=indent "fdm
set foldnestmax=5     "fdn max fold level
set foldlevel=5       "fdl default fold level
	"簡單的說，就是可以將文章內容，依據他的結構，把多行內容集中於其中一個代表行來顯示，螢幕上只看得到章節標題那一代表行，這樣整個文章結構就一目了然，真正要閱讀其他內容時，再由簡單的按鍵或滑鼠來打開。"

" set scroll offset(the min number of lines above and below cursor) to 2
set scrolloff=2       "so
	"捲動時保留2行"
" enable mouse in all mode
set mouse=a

" hichlight current line
set cursorline

" highlight syntax
syntax on
	"Turn On or Off Color Syntax Highlighting In vi or vim Editor

" color scheme
colorscheme kolor

" make whitespaces and TABs visible
"l
set list
"lcs
set listchars=tab:>-,trail:·
highlight SpecialKey guifg=DarkGray

" set temp dirs, can speedup 100x when working on fuse via internet or nfs
"set backupdir=~/.vim/bak/
"set directory=~/.vim/swp/
"set undodir=~/.vim/undo/

" map hot key <Ctrl>+m to switch paste mode
map <C-o> :set paste!<BAR>set paste?<CR>
" map hot key <Ctrl>+n to switch if shows line numbers
map <C-n> :set nu!<BAR>set nu?<CR>
" map hot key <Ctrl>+h to switch if highlights current working column
map <C-g> :set cursorcolumn!<BAR>set cursorcolumn?<CR>
" map hot key <Ctrl>+h to switch if highlights current working line
map <C-h> :set cursorline!<BAR>set cursorline?<CR>

" map tab / shift-tab to add/remove indent in normal & visual modes
nmap <tab>   v>
nmap <s-tab> v<
vmap <tab>   >gv
vmap <s-tab> <gv

" map F9 to save and make
map <F9> :w <CR> :make <CR>
" map F10 to execute filename(without ext.) as external command (usually for c & cpp)
map <F10> :!./%< <CR>
" map F11 = F9 + F10
map <F11> :w <CR> :make <CR> :!./%< <CR>

"=== setting depends on filetype  ==="
" au, autocommand
autocmd FileType make,gitconfig,gitcommit,apache setlocal et!
autocmd FileType gitcommit setlocal cc=50 | highlight ColorColumn ctermbg=cyan
autocmd FileType html,css,javascript setlocal sw=2 ts=2
autocmd FileType fstab setlocal sw=8 ts=8

"=== manually setting filetype ==="
" au, autocommand
autocmd BufRead,BufNewFile *.cpp set filetype=cpp
autocmd BufRead,BufNewFile *.plt set filetype=gnuplot
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile named.conf* set filetype=named
autocmd BufRead,BufNewFile *.pac set filetype=javascript

" set makeprg(depends on filetype) if makefile is not exist
if !filereadable('makefile') && !filereadable('Makefile')
    autocmd FileType c setlocal makeprg=gcc\ %\ -o\ %<
    autocmd FileType cpp setlocal makeprg=g++\ %\ -o\ %<
    autocmd FileType sh setlocal makeprg=bash\ -n\ %
    autocmd FileType php setlocal makeprg=php\ -l\ %
endif

" set Netrw's default style to tree style listing
let g:netrw_liststyle=3

"=== IF YOU WANT TO USE THE FOLLOWING FEATURE, PLEASE UNCOMMENT IT BY YOURSELF ==="

" remember and go to the last used location automatically.
"autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" auto remove trailing whitespace when saving file
"autocmd BufWritePre * :%s/\s\+$//e
