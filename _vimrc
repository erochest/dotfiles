
" turn autoindent on
set ai
" backspace over everything in indent mode
set bs=2
" keep a backup
set backup
" keep 50 lines of command line history
set history=50
" show cursor position
set ruler
" high-light sought-for strings
set hlsearch
" incremental searching
set incsearch
" set the fold column so i can click on it
"set foldcolumn=2
" turn on the wildcard menu
set wildmenu
"set wildmode=list:longest,full
" turn on modelines (this appears to be off on ubuntu)
set modeline

filetype plugin on

"switch syntax highlighting on
if &t_Co > 2 || has("gui_running")
	syntax on
	if filereadable(expand("<sfile>:p:h") . "/.vimcolor")
		source <sfile>:p:h/.vimcolor
	endif
endif


"if has("gui_running")
"	set columns=101
"end


map <C-Up> :bn<CR>
map <C-Down> :bp<CR>

map <C-n> :n<CR>
map <C-p> :N<CR>
map <C-m> :cn<CR>zvzz

nmap <LocalLeader>f gqap
"nmap <LocalLeader>H V"zy2"zpk:s/./=/g<CR>2j:s/./=/g<CR>
"nmap <LocalLeader>h V"zy2"zpk:s/./-/g<CR>2j:s/./-/g<CR>

"nmap <LocalLeader>x Ix<space><C-r>=strftime("%Y-%m-%d")<CR><space><ESC>

iab mdyc <C-r>=strftime("%c")<CR>

set encoding=utf-8

" settings for taglist and Pydoc
if has("X11")
	let Tlist_Ctags_Cmd="ctags"
	let g:pydoc_cmd = "python2.5 -m pydoc"
	set guifont=DejaVu\ Sans\ Mono\ 10
elseif has("win32") && filereadable("C:\\Python25\\python.exe")
	let Tlist_Ctags_Cmd="ctags.exe"
	let g:pydoc_cmd = "C:\\Python25\\Lib\\pydoc.py"
	set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
elseif has("win32") && filereadable("D:\\Python25\\python.exe")
	let Tlist_Ctags_Cmd="ctags.exe"
	let g:pydoc_cmd = "D:\\Python25\\Lib\\pydoc.py"
	set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
elseif has("win32")
	let Tlist_Ctags_Cmd="ctags.exe"
	set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
end
map <F4> :Tlist<CR>

" for using the putty scm
let g:netrw_cygwin=0

" for aspell
"map <C-t> :w!<CR>:!aspell check %<CR>:e! %<CR>

" dbext settings
let g:dbext_default_SQLITE_bin="sqlite3"

" set grepprg to use egrep
" set the scp command to use putty
if has("win32")
    set grepprg=egrep\ -n
    let g:netrw_scp_cmd="scp.exe -q -batch"
    nmap <F11> :silent !start explorer /e,,%:p:h,/select,%:p<CR>
end

" rotate colorscheme
let themeindex=0
function! RotateColorScheme()
    let y = -1
    while y == -1
        let colorfiles = globpath(&runtimepath, "colors/*.vim")
        let colorstring = substitute(colorfiles, "\n", "#", "g")
        let x = match(colorstring, "#", g:themeindex)
        let y = match(colorstring, "#", x+1)
        let g:themeindex = x + 1
        if y == -1
            let g:themeindex = 0
        else
            let themestring = strpart(colorstring, x+1, y-x-1)
            echo("Setting colorscheme to " . themestring)
            return ":so ".themestring
        endif
    endwhile
endfunction
map <F8> :execute RotateColorScheme()<CR>

" switch windows on tab
nmap <Tab> <C-W>W

" switch tabs on CTRL-tab
nmap <C-Tab> gt

nmap <LocalLeader>log Go<C-r>=strftime("%m/%d/%Y %H:%M")<CR><Space>
nmap <LocalLeader>done G2Ea-<C-r>=strftime("%m/%d/%Y %H:%M")<CR><ESC>o<C-r>=strftime("%m/%d/%Y %H:%M")<CR><Space>
nmap <LocalLeader>dh o<CR><C-r>=strftime("%d %b %Y")<CR><ESC>"zyy"zp:s/./=/g<CR>:nohl<CR>j

nmap <F5> :NERDTreeToggle<CR>

" smart quotes and long dashes
"   NB: Removed to force me to use the standard digraphs
"imap <LocalLeader>," “     " "6
"imap <LocalLeader>." ”     " "9
"imap <LocalLeader>.' ’     " '9
"imap <LocalLeader>m- —     " -M
"imap <LocalLeader>n- –     " -N

" OTL (vim outliner) settings
" defaults
let g:otl_install_menu=1
let g:no_otl_maps=0
let g:no_otl_insert_maps=0
let g:otl_use_viki=0
" overrides
let g:otl_bold_headers=0
let g:otl_use_thlnk=0

" Erlang mode settings
let g:erlangCompiler="emake"

" Haskell settings
if has("X11")
	let g:haddock_browser = "firefox"
	let g:haddock_docdir="/usr/local/share/doc/ghc/libraries"
	let g:haddock_indexfiledir="~/vimfiles"
elseif has("win32")
	let g:haddock_browser = "C:/Documents and Settings/erochester/Local Settings/Application Data/Google/Chrome/Application/chrome.exe"
	let g:haddock_docdir="C:/ghc/hgc-6.10.1/doc"
	let g:haddock_indexfiledir="~/vimfiles"
end

" dbext profiles
let g:dbext_default_profile_rochester_hm = 'type=SQLSRV:srvname=ROCHESTER-HM\SQLEXPRESS:dbname=Lse:integratedlogin=1'
let g:dbext_default_profile_wh_pub_01 = 'type=SQLSRV:srvname=WH-PUB-01:dbname=EP_Sample:integratedlogin=1'
let g:dbext_default_profile_lsedb_dev = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=C:\home\eric\src\ase\lsedb\lsedb.db'

