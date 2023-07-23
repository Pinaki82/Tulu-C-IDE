" Credit: https://github.com/Pinaki82/Tulu-C-IDE
" Taken from "Tulu-C-IDE", A simple Vim text editor configuration
"      that lets you edit C/C++ codes efficiently.
" Licence: BSL + MIT-0 + GNU-GPL + FreeBSD
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"  ===========================================================
"                  TERMINAL EMULATORS
"
" Linux Debian/Ubuntu: Use Kitty/Alacritty.
"                          sudo apt install kitty. sudo apt install alacritty.
"                      All other emulators create some trouble, like:
"                      CTRL+] will change the Mode from Insert to Normal.
" MS Windows: The default Windows Terminal with cmd/ps (Alacritty
"              and Wezterm create trouble. Kitty is not available on Windows).
"  ===========================================================

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set runtimepath+=$HOME\/\.vim

" ============================================

" ============================================
" how to start vim with a specific width and height
" https://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim


if !has("gui_running")
  " When the GUI is not running and Vim is started from the terminal.
  if exists("+lines")
    " set lines=43
  endif
  if exists("+columns")
    set columns=151
  endif
endif
" ============================================

" ============================================
"  ******************************************
" ============================================
" http://vi.stackexchange.com/questions/2572/detect-os-in-vimscript
" google: detecting os from vimscript
if !exists("g:osdetected")
  if has("win64") || has("win32") || has("win16") || has("win32unix")
    let g:osdetected = "Windows"
  elseif has("macunix")
    let g:osdetected = substitute(system('uname'), '\n', '', '')
  else
    let g:osdetected = substitute(system('uname'), '\n', '', '')
  endif
endif

" After that, you can use the g:osdetected variable anywhere in your vimrc:

" ============================================

" ============================================

source $VIMRUNTIME/mswin.vim
behave mswin

set nocompatible

filetype on
filetype plugin on
filetype indent on            " Enable filetype-specific indenting
filetype plugin indent on   " Automatically detect file types.
syntax enable
set grepprg=grep\ -nH\ $*

" -------------------- Relative & Hybrid Line No. -----------------------
" https://jeffkreeftmeijer.com/vim-number/
" Shows Absolute Line Numbers in the Insert Mode and
" Relative Line Numbers in the Normal Mode.
set ruler
set number        " always shows line numbers
set nu
set relativenumber
set rnu
set number relativenumber        " turn hybrid line numbers on
set nu rnu
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
" -----------------------------------------------------------------------
set laststatus=2
:set timeout timeoutlen=4500 "   ttimeoutlen=100 "  default settings -1 not harmed under comment
set history=1000                " Store a ton of history (default is 20)
" remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
"     Disable Beep and Window Flash and stop vim making noise
set noeb vb t_vb=
set vb t_vb=

set tabstop=2     " a tab is two spaces
set backspace=indent,eol,start
" allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set smartindent
set copyindent    " copy the previous indentation on autoindenting
set preserveindent              " save as much indent structure as possible
set shiftwidth=2  " number of spaces to use for autoindenting
set softtabstop=2
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
"    case-sensitive otherwise
set expandtab     " Spaces are better than a tab character
set smarttab      " insert tabs on the start of a line according to
"    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set nohidden      " When I close a tab, remove the buffer
set complete=.,w,b,u,U,k,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
set showcmd                     " Show (partial) command in status line.

set formatoptions=tcrql         " t - autowrap to textwidth
" c - autowrap comments to textwidth
" r - autoinsert comment leader with <Enter>
" q - allow formatting of comments with :gq
" l - don't format already long lines


" Swap ; and :  Convenient. No more you will need to type Shift+: for going into command mode
" Just hit ; in normal mode everything will be done.
nnoremap ; :
" nnoremap : ;
" dont uncomment the line above, this disables Shift+: completely.


" Restore cursor position to where it was before
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \   if line("'\"") > 1 && line("'\"") <= line("$") |
        \     let JumpCursorOnEdit_foo = line("'\"") |
        \     let b:doopenfold = 1 |
        \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \        let b:doopenfold = 2 |
        \     endif |
        \     exe JumpCursorOnEdit_foo |
        \   endif |
        \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \   exe "normal zv" |
        \   if(b:doopenfold > 1) |
        \       exe  "+".1 |
        \   endif |
        \   unlet b:doopenfold |
        \ endif
augroup END

set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility

if !has("gui_running") && (!has('win32') && !has('win64'))
  set term=$TERM       " Make arrow and other keys work
endif

set showmatch                   " show matching brackets/parenthesis

:hi ColorColumn ctermbg=lightgrey guibg=lightgrey

"  The following line is Very Very Important For Tags searching from current directory
set tags+=./tags;/

" autocomplete menu
set wildmenu
set wildmode=list:longest,full
set mouse=a

" c like indentation
set cindent
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


" -----------------------------------------------------------------------------------
" mapping some more keys ::
" http://superuser.com/questions/10588/how-to-make-cut-copy-paste-in-gvim-on-ubuntu-work-with-ctrlx-ctrlc-ctrlv
" and from earlier documentations

" CTRL-X is cut
if g:osdetected == "Windows"
  vnoremap <c-x> "+x
  ""  elseif g:osdetected == "Linux"
  ""    map <c-x> "+x
  ""    map! <c-x> "+x
  ""    nmap <c-x> "+x
  ""    smap <c-x> <c-g>x
  ""    vnoremap <C-X> "+x
  ""    nnoremap <c-x> "+x
  ""    inoremap <c-x> "+x
  ""    vmap <c-x> "+c
  ""    imap <c-x> "+x
endif

" CTRL-C is copy
if g:osdetected == "Windows"
  vnoremap <C-C> "+y
elseif g:osdetected != "Windows"
  vmap <C-c> "+yi
  vnoremap <C-C> "+y
  :imap <C-C> "+y
endif

" CTRL-V is paste
if g:osdetected == "Windows"
  vnoremap <C-V> "+gP
elseif g:osdetected != "Windows"
  :imap <C-V> "+gP
  imap <C-v> <C-r><C-o>+
  nmap <<C-V>> "+gP
  vmap <C-v> c<ESC>"+p
  vnoremap <C-V> "+gP
endif

" CTRL-S is save
if g:osdetected != "Windows"
  :noremap <c-s> <Esc>:w<CR>
  :inoremap <c-s> <c-o>:w<CR>
endif
" -----------------------------------------------------------------------------------

" to paste blockwise, uses paste.vim autoload script
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']


" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Z is undo
if g:osdetected == "Windows"
  vnoremap <C-Z> u
elseif g:osdetected != "Windows"
  :map <C-z> u
  nnoremap <C-Z> u
  inoremap <C-Z> <C-O>u
  vnoremap <C-Z> u
endif


" CTRL-Y is redo
if g:osdetected == "Windows"
  vnoremap <C-Y> ^R
elseif g:osdetected != "Windows"
  :nnoremap <C-Y> :call Redo_action() <CR>
  :vnoremap <C-Y> :call Redo_action() <CR>
  :inoremap <C-Y> <C-O> :call Redo_action() <CR>
  imap <C-Y> <C-O> :call Redo_action()<CR><CR>
  fun Redo_action()
    :redo
  endfun
endif

" ------------------------------------------------------------------
" CTRL-F4 (SHIFT-F4 on Linux) is close
" https://stackoverflow.com/questions/2066590/automatically-quit-vim-if-nerdtree-is-last-and-only-buffer

function CloseFile()
  if ((winnr('$') > 1))
    echo 'Type no if you want to skip closing the file!'
    " https://stackoverflow.com/questions/14388703/vim-mapping-with-user-input
    if input("Unsaved changes will be lost! Proceed[y/no]? ") != "no"
      :e!
      :bd
      :e!
    endif
  elseif ((winnr('$') <= 1))
    "  https://vi.stackexchange.com/questions/8876/echo-message-on-startup-without-prompting
    echo 'Cannot delete the last buffer!'
  endif
endfunction

vnoremap <C-F4> :call CloseFile() <Enter>
nnoremap <C-F4> :call CloseFile() <Enter>
inoremap <C-F4> :call CloseFile() <Enter>
if g:osdetected != "Windows"
  vnoremap <S-F4> :call CloseFile() <Enter>
  nnoremap <S-F4> :call CloseFile() <Enter>
  inoremap <S-F4> :call CloseFile() <Enter>
endif
" ------------------------------------------------------------------

" CTRL-D is Buffer Delete
map <C-D> <Esc>:confirm bd <CR><Esc>

" make text uppercase F5 and lowercase SHIFT-F5 respectively
:map! <F5> <Esc>gUiw`]a
:map! <S-F5> <Esc>guiw`]a

" nmap <F11> :TagbarToggle<CR>
" map <S-F11> :Tlist <Enter>

" ----- Press 'jk' to '<ESC>' ----------- "
" ----- While in the Insert Mode, press 'jk' instead of '<ESC>' to go back to the Normal Mode ----------- "
" ----------------------------- " https://stackoverflow.com/questions/23946748/vim-imap-jk-esc-not-working-even-with-escape-character
" ----------------------------- " https://medium.com/diegodev/vim-tip-remapping-jj-to-escape-8efc4ad8a6bf
" ----------------------------- " https://allsyed.com/posts/7-most-useful-vim-mappings/
inoremap <special> jk <ESC>
imap jk <Esc>
inoremap <special> kj <ESC>
imap kj <Esc>
" ------------------------------------------------------------------

set wrap!   " Disables Word Wrap on start
:autocmd GUIEnter * winpos 0 0 " Starts window position to 0,0 coordinate
" :set lines=1152 columns=864 "   ~~~~~~~~~~~CUSTOMIZE this to match your Desktop Resolution

" omnicppcomplete options
set tags+=~/.vim/commontags

" --- OmniCppComplete ---
" -- required --
set nocp " non vi compatible mode
filetype plugin on " enable plugins
"   put to command :set omnifunc? and see what type of completion is in current use


" -----------------------------------------------------------------------------------
set tags+=./tags;/
set path+=./;/
" -----------------------------------------------------------------------------------

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set guioptions+=b "Bottom Scrollbar always turned on
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" -----------------------------------------------------------------------------------
autocmd BufWritePre * :call <SID>StripWhite()
fun! <SID>StripWhite()
  %s/[ \t]\+$//ge
  %s!^\( \+\)\t!\=StrRepeat("\t", 1 + strlen(submatch(1)) / 8)!ge
endfun

"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                       Turn on/off Word Wrap
:menu Settings.Word\ Wrap\ on <Esc>:set wrap<Esc>
:menu Settings.Word\ Wrap\ off\ :nowrap <Esc>:set nowrap<Esc>
" ~~~~~~~ Set default wrap settings to nowrap in GUI mode
if has("gui_running")
  :set nowrap
endif
"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                       Function for the line-col highlight feature

" Execute only once
if exists("g:highlight_line_n_column")
  finish
endif
let g:highlight_line_n_column=0


function! ToggleHighlightLineColumn()
  if g:highlight_line_n_column == 1

    call HighlightLineColOn()

    let g:highlight_line_n_column = 0
  else

    call HighlightLineColOff()

    let g:highlight_line_n_column = 1
  endif
endfunction


fun! HighlightLineColOn()
  :set cursorline
  :set cursorcolumn
  :redir => cursorline_highlight | silent highlight CursorLine | redir END
  :highlight CursorLine  term=underline cterm=underline
  :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
  :highlight CursorColumn  term=underline cterm=underline
endfun

fun! HighlightLineColOff()
  :set nocursorline
  :set nocursorcolumn
endfun



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Setting up the directories {
"" Backup directories can be created from the temporary.vim plugin.
" Look at the plugin folder for the file temporary.vim containing the same lines.
"" Creating directories if they don't exist
if g:osdetected == "Linux"
  " silent execute '!mkdir "'.$HOME.'/.vimbackup"'
  " silent execute '!mkdir "'.$HOME.'/.vimswap"'
  " silent execute '!mkdir "'.$HOME.'/.vimviews"'
  " silent execute '!mkdir "'.$HOME.'/.vimundo"'
endif

set backup                      " backups are nice ...
" Moved to function at bottom of the file
set backupdir=$HOME/.vimbackup//  " but not when they clog .
set directory=$HOME/.vimswap//     " Same for swap files
set viewdir=$HOME/.vimviews//  " same for view files
set undodir=$HOME/.vimundo//  " same for undo

au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
" }
" }


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Windows Compatible {
" http://spf13.com/post/perfect-vimrc-vim-config-file
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath+=$HOME/\.vim,$HOME/\.vim/after,
endif
" }
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~ Copy Present Working Directory (pwd) to system clipboard ~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" let @* = expand('%:p:h')
" https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
" https://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim

if g:osdetected == "Windows"
  function! CopyPWDToWindowsNMacOSXClipboard()
    :let @* = expand('%:p:h')
  endfun
elseif g:osdetected == "Linux"
  function! CopyPWDToLinuxClipboard()
    :let @+ = expand('%:p:h')
  endfun
else
  function! CopyPWDToSystemClipboard()
    :let @* = expand('%:p:h')
    :let @+ = expand('%:p:h')
  endfun
endif

" Opens Explorer
if g:osdetected == "Windows"
  " :amenu Utilities.Copy\ pwd\ to\ System\ Clipboard\ (\:Pwdtoclip\) :call CopyPWDToWindowsNMacOSXClipboard() <Esc>
  command! Pwdtoclip :call CopyPWDToWindowsNMacOSXClipboard()
elseif (g:osdetected == "Linux")
  " :amenu Utilities.Copy\ pwd\ to\ Linux\ Clipboard\ (\:Pwdtoclip\) :call CopyPWDToLinuxClipboard() <Esc>
  command! Pwdtoclip :call CopyPWDToLinuxClipboard()
else
  " :amenu Utilities.Copy\ pwd\ to\ System\ Clipboard\ (\:Pwdtoclip\) :call CopyPWDToSystemClipboard() <Esc>
  command! Pwdtoclip :call CopyPWDToSystemClipboard()
endif
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" =======================================================================
" ************************ VIM-PLUG PLUGIN SETUP ************************
" =======================================================================

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.vim/plugged')


" ------------------------------- OS specific Initialisation -----------
" https://vi.stackexchange.com/questions/2572/detect-os-in-vimscript
if has("win64") || has("win32") || has("win16") || has("win32unix")
  call plug#begin('$HOME\/\.vim\plugged')
else
  call plug#begin('~/.vim/plugged')
endif


" Make sure you use single quotes

Plug 'https://github.com/junegunn/vim-plug.git'
Plug 'mhinz/vim-startify' " -- Fancy start screen
Plug 'vim-airline/vim-airline'

" ******************************************************************************
" ******************************************************************************
" ******************************************************************************
" ******************************************************************************
" ====== AUTOCOMPLETION+CODE_CHECKING PLUGIN ===========================
" ==============================================================================

" # Using Ubuntu
" sudo apt install clangd
" sudo apt install curl
" ============== MSYS2:
" https://github.com/msys2/MINGW-packages/issues/4788
" ===== Dnld the ZIP. Extract to "C:\msys64\opt\"
" export PATH=/opt/node-v14.17.5-win-x64/:$PATH >> ~/.bash_profile
" <WINDOWS+R> ---> systempropertiesadvanced ---> Advanced ---> Environment Variables ---> System Variables ---> Path ---> Edit ---> New ---> Paste the location from the clipboard (C:\msys64\opt\node-v14.17.5-win-x64)

Plug 'https://github.com/dense-analysis/ale.git'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 6 " asyncrun settings
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'https://github.com/rhysd/vim-lsp-ale.git'
Plug 'Shougo/ddc.vim'
Plug 'shun/ddc-vim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" ================================== For 'hrsh7th/vim-vsnip'
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
" ================================== For 'hrsh7th/vim-vsnip' ===================
Plug 'normen/vim-pio'    " -- PlatformIO MCU Development - will be tested later.
Plug 'stevearc/vim-arduino' " -- Arduino MCU Development - will be tested later.
" ====== RUSTC/Cargo Support (NOTE: Syntx Highlighting Only)
Plug 'rust-lang/rust.vim'
" https://blog.logrocket.com/configuring-vim-rust-development/#rust-analyzer
" MS Windows 10 x64
" pacman -S mingw-w64-x86_64-rust
" pacman -S mingw-w64-x86_64-cargo-c
" Or
" https://forge.rust-lang.org/infra/other-installation-methods.html
" x86_64-pc-windows-gnu


" Plug 'https://github.com/Pinaki82/Omni-Completion-at-CTRL-SPACE.git'
" Plug 'https://github.com/vim-scripts/AutoComplPop.git'

Plug 'https://github.com/Pinaki82/code_complete.git'

" ==============================================================================
" ====== (END) AUTOCOMPLETION+CODE_CHECKING PLUGIN =====================
" ******************************************************************************

" https://vi.stackexchange.com/questions/2094/how-to-make-vimrc-settings-applicable-for-a-directory-tree-only
Plug 'https://github.com/embear/vim-localvimrc.git'

Plug 'https://github.com/preservim/nerdtree.git'

Plug 'https://github.com/vim-scripts/matchparenpp.git'

Plug 'https://github.com/tpope/vim-unimpaired.git'

Plug 'https://github.com/matze/vim-move.git'

Plug 'https://github.com/preservim/nerdcommenter.git'

Plug 'https://github.com/vim-scripts/AutoClose.git'

Plug 'https://github.com/WolfgangMehner/vim-plugins.git'

Plug 'https://github.com/lambdalisue/gina.vim.git'

Plug 'https://github.com/Pinaki82/git-difftool.git'

Plug 'https://github.com/weynhamz/vim-plugin-minibufexpl.git'

Plug 'https://github.com/xuhdev/SingleCompile.git'

Plug 'https://github.com/artnez/vim-wipeout.git'

Plug 'https://github.com/Pinaki82/artistic_styler_console_direct.vim.git'

Plug 'https://github.com/Pinaki82/VimLongLineMarker.git'

Plug 'https://github.com/Pinaki82/vim-move-Keyboard-Shortcut.git'

Plug 'https://github.com/Pinaki82/TimeStamp2.git'

Plug 'https://github.com/Shougo/echodoc.vim.git'

Plug 'https://github.com/vim-scripts/stlrefvim.git'

Plug 'https://github.com/Pinaki82/crefvim2.git'

Plug 'https://github.com/vim-scripts/YankRing.vim.git'

Plug 'https://github.com/Pinaki82/Reload-Button.git'

Plug 'https://github.com/Pinaki82/convert-line-endings.git'

Plug 'https://github.com/rhysd/vim-grammarous.git'

Plug 'https://github.com/kenng/vim-bettersearch.git'

Plug 'https://github.com/vim-scripts/TaskList.vim.git'

" ----- https://liuchengxu.github.io/posts/vista.vim/
" ----- https://github.com/liuchengxu/vista.vim.git
Plug 'liuchengxu/vista.vim'

Plug 'https://github.com/Pinaki82/Clear-Search-Highlight-in-Vim.git'

Plug 'https://github.com/Pinaki82/repeaterchar.vim.git'

Plug 'https://github.com/Pinaki82/tracktime.vim.git'

Plug 'https://github.com/Pinaki82/indent-code.git'

Plug 'https://github.com/ciaranm/detectindent.git'

Plug 'https://github.com/Pinaki82/vim-jsnippets.git'

Plug 'https://github.com/drmingdrmer/xptemplate.git'

Plug 'Exafunction/codeium.vim'
"            C              " Close to GitHub Copilot
"            o            AI Supercharged autocompetion
"            d            Infuse AI into your codeing
"            ium          https://codeium.com/vim_tutorial

"                            === Eye candy third-party Vim colour schemes
Plug 'arcticicestudio/nord-vim'

Plug 'drewtempelmeyer/palenight.vim'

Plug 'https://github.com/ghifarit53/tokyonight-vim.git'

"                            === (END) Eye candy third-party Vim colour schemes

" ==================================================

" Initialize plugin system
call plug#end()

" =======================================================================
" ************************ VIM-PLUG PLUGIN SETUP ENDS *******************
" =======================================================================

"  ===========================================================
"                  PLUGIN SETTINGS
"  ===========================================================

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~ vim-grammarous grammar check with LanguageTool ~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" check comments only in source code by default:
let g:grammarous#default_comments_only_filetypes = {
      \ '*' : 1, 'help' : 0, 'markdown' : 0,
      \ }
" let g:grammarous#use_vim_spelllang = 1
let g:grammarous#show_first_error = 1
" ------------------------------
" Create a folder called 'misc' where 'autoload', 'doc', 'plugin', and 'rplugin'
" folders are located (if you are using a plugin manager) or
" create that 'misc' folder in .vim directory.
" Extract "languagetool-*.zip" in the 'misc' folder.
" Download LanguageTool from https://languagetool.org/download/
" ------------------------------

" ====================================
" ========= AutoComplPop setup =======
" ====================================
let g:acp_enableAtStartup = 1
let g:acp_mappingDriven = 0
let g:acp_completeoptPreview = 1

:amenu Plugin.ACP-auto-popup.enables\ auto-popup :AcpEnable <Esc>
:amenu Plugin.ACP-auto-popup.disables\ auto-popup :AcpDisable <Esc>
:amenu Plugin.ACP-auto-popup.suspends\ auto-popup\ temporarily :AcpLock <Esc>
:amenu Plugin.ACP-auto-popup.resumes\ auto-popup\ previously\ suspended :AcpUnlock <Esc>
" ====================================

"  ======================================================
" ~~~~~~~~~~~ YankRing plugin Configuration ~~~~~~
:nnoremap <silent> <C-F11> :YRShow<CR>
function! YRRunAfterMaps()
  nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction
" ~~~~~~~~~~~ YankRing plugin Configuration ends ~~~~~~

" ------------------- echodoc plugin settings
" To use echodoc, you must increase 'cmdheight' value.
" https://github.com/Shougo/echodoc.vim.git
set cmdheight=2
let g:echodoc_enable_at_startup = 1

" ========================== ALE Linter Settings ==========
" ==================== UNCOMMENT the entire ALE Linter SETTINGS if
" ====================== you chose the OPTION TWO for autocompletion and code
" ====================== checking ===============================

let g:ale_c_cppcheck_options = '--enable=all --enable=style --enable=performance --enable=portability --enable=information --enable=unusedFunction --enable=missingInclude --inconclusive --force --suppress=missingIncludeSystem'
let g:ale#statusline#Count = 1
let g:ale#statusline#FirstProblem = 1

let g:ale_set_quickfix = 1

" Map movement through errors
" LEFT CTRL + k = UP/PREV
" LEFT CTRL + FULL STOP = DOWN/NEXT
" k . UP DOWN
" Map movement through errors without wrapping.
nmap <silent> <C-k> <Plug>(ale_previous)
" OR map keys to use wrapping.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

" CTRL-. is ale_next_wrap on Windows
if g:osdetected == "Windows"
  :nmap <silent> <C-.> <Plug>(ale_next)
  :nmap <silent> <C-.> <Plug>(ale_next_wrap)
  " CTRL-m is ale_next_wrap on UNIX-like systems
elseif g:osdetected != "Windows"
  :nmap <silent> <C-m> <Plug>(ale_next)
  :nmap <silent> <C-m> <Plug>(ale_next_wrap)
endif

" let g:ale_cpp_gcc_header_extensions = ['h']

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clangtidy'],
\   'cpp': ['clangtidy'],
\   'c-header': ['clangtidy'],
\   'cpp-header': ['clangtidy'],
\}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

"
" ~~~~~ Add the following lines to your `.lvimrc` file (uncommented)
" ~~~~~   for editing C header files with the `.h` extension.
" ~~~~~ Some GCC/Clang versions along with certain versions of certain plugins might cause troubles with C header files [E.g., clang version 16.0.2 (MSYS2), gcc version 13.1.0 (MSYS2)].
" ~~~~~ Setting the file type as C will temporarily solve the problem.
" ~~~~~ :set filetype=c
" ~~~~~ However, this is not ideal since reloading the file will bring back the same issues.
" ~~~~~ So, you may like to add the following lines to your LocalVimrc config `.lvimrc` file.
"
"             let g:ale_cpp_gcc_header_extensions = ['h'] " Bing Chat gave me the solution
"             autocmd BufNewFile,BufRead *.h set filetype=c
"
" ========================== (END) ALE Linter Settings ==========

" ========================== TaskList.vim Settings ==========
" Mapped Keys: <Leader>t   Display list.
"                 The following keys are mapped to the results window:
"
"                     q - Quit, and restore original cursor position.
"
"                     e - Exit, and keep results window open note that
"                         movements on the result window will no longer be
"                         updated.
"
"                     <cr> - Quit and place the cursor on the selected line.
"
" Tokens: FIXME TODO NOTE XXX OPTIMIZE OPTIMISE HACK BUG SEGFAULT
"         INSECURE WARNING NOBUG REQ RFE IDEA ??? !!! PORT CAVEAT
"         FAQ GLOSS SEE TODOC CRED STAT RVD
" Meanings: https://peps.python.org/pep-0350/
"           https://stackoverflow.com/questions/1452934/what-is-the-meaning-of-xxx-in-code-comments
"
"
let g:tlTokenList = ['FIXME', 'TODO', 'NOTE', 'XXX', 'OPTIMIZE', 'OPTIMISE', 'HACK', 'BUG', 'SEGFAULT', 'INSECURE', 'WARNING', 'NOBUG', 'REQ', 'RFE', 'IDEA', '???', '!!!', 'PORT', 'CAVEAT', 'FAQ', 'GLOSS', 'SEE', 'TODOC', 'CRED', 'STAT', 'RVD']
let g:tlRememberPosition = 1
" ========================== (END) TaskList.vim Settings ==========

" -----------------------------------------
" Codeium Plugin Settings
let g:codeium_filetypes = {
    \ "c": v:true,
    \ "typescript": v:true,
    \ "python": v:true,
    \ "cpp": v:true,
    \ "rust": v:true,
    \ }

let g:codeium_disable_bindings = 0 " Keep the default keybindings
let g:codeium_enabled = v:true     " Always enable Codeium at startup
let g:codeium_manual = v:false     " Always automatically trigger completions

function! OpenCodeiumLSDirectory()
  if has("win64") || has("win32") || has("win16") || has("win32unix")
    :execute "silent !start \"" . substitute($HOME . "/.codeium/bin/", "\"", "\\\"", "g") . "\""
  else
    :silent!!xdg-open "$HOME/.codeium/bin" &
  endif
endfunction

command! CodeiumLangServerBinDir :silent! call OpenCodeiumLSDirectory()
:amenu AI.Codeium.Explore\ \Codeium\ \Language\ \Server\ \bin\ \Directory\ \(\:CodeiumLangServerBinDir\) :call OpenCodeiumLSDirectory() <Esc>

let g:airline_section_y = '{}%3{codeium#GetStatusString()}'

" Clear current suggestion	codeium#Clear()	<C-]>
" Next suggestion	codeium#CycleCompletions(1)	<M-]>
" Previous suggestion	codeium#CycleCompletions(-1)	<M-[>
" Insert suggestion	codeium#Accept()	<Tab>
" Manually trigger suggestion	codeium#Complete()	<M-Bslash>
"

" -----------------------------------------

" -----------------------------------------
" Localvimrc Plugin Settings
" https://github.com/embear/vim-localvimrc.git

let g:localvimrc_sandbox=0 " Disable loading local vimrc files in a sandbox; Forget security reasons
                           " Essential for running make (and a few other commands) using Localvimrc.
                           " Default: 1
let g:localvimrc_ask=0 " Ask before sourcing any local vimrc file.
                       " In a vim session the question is only
                       " asked once as long as the local vimrc file
                       " has not been changed.

                       " Value 0: Don't ask before loading a vimrc file.
                       " Value 1: Ask before loading a vimrc file.
                       " Default: 1

let g:localvimrc_persistent=2 " Make the decisions given when asked before
                              " sourcing local vimrc files persistent over
                              " multiple vim runs and instances.
                              " https://github.com/embear/vim-localvimrc#the-glocalvimrc_persistent-setting

                              " Value 0: Don't store and restore any decisions.
                              " Value 1: Store and restore decisions only
                              "           if the answer was given
                              "           in upper case (Y/N/A).
                              " Value 2: Store and restore all decisions.
                              " Default: 0

" -----------------------------------------

" -----------------------------------------
" Vista Plugin (Tagbar alternative) config
" ----- https://github.com/liuchengxu/vista.vim.git
" ----- https://liuchengxu.github.io/posts/vista.vim/
"
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["? ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["?-? ", "+-? "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'vim_lsp'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'c': 'vim_lsp',
  \ 'cpp': 'vim_lsp',
  \ 'rust': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" -----------------------------------------

"  ===========================================================
"                  (END) PLUGIN SETTINGS
"  ===========================================================

" ============================================
" ============================================
let g:ascii = [
    \ '    ______      __            ______     ________  ______',
    \ '   /_  __/_  __/ /_  __      / ____/    /  _/ __ \/ ____/',
    \ '    / / / / / / / / / /_____/ /  ______ / // / / / __/   ',
    \ '   / / / /_/ / / /_/ /_____/ /__/_____// // /_/ / /___   ',
    \ '  /_/  \__,_/_/\__,_/      \____/    /___/_____/_____/   ',
    \ ''
    \]
let g:startify_custom_header =
          \ startify#pad(g:ascii + startify#fortune#boxed())
" ============================================
" ============================================

" ============================================================================
" ======================== About & Help Menu =================================
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Open About & Help in the default internet browser.
if g:osdetected == "Windows"
  function! Help_n_Tutorial_and_About_open_Windows_Explorer()
    :silent! !explorer "https://github.com/Pinaki82/Tulu-C-IDE/blob/main/README.md"
  endfun

  :amenu Help.Tulu-C-IDE\ About\ and\ Tutorial\ \(\:TuluAbout\) :call Help_n_Tutorial_and_About_open_Windows_Explorer() <Esc>
  command! TuluAbout :call Help_n_Tutorial_and_About_open_Windows_Explorer()

elseif g:osdetected == "Linux"
  " https://askubuntu.com/questions/15354/how-to-open-file-with-default-application-from-command-line#:~:text=is%20not%20useful-,Show%20activity%20on%20this%20post.,in%20the%20user's%20preferred%20application.
  function! Help_n_Tutorial_and_About_open_Xdg()
    :silent!!xdg-open "https://github.com/Pinaki82/Tulu-C-IDE/blob/main/README.md" &
    if !has("gui_running")
      :source ~/.vimrc
      :source ~/.vimdotcommon/.vimrc2.vim
      :source ~/.vim/plugin/temporary.vim
    endif
  endfun

  :amenu Help.Tulu-C-IDE\ About\ and\ Tutorial\ \(\:TuluAbout\) :call Help_n_Tutorial_and_About_open_Xdg() <Esc>
  command! TuluAbout :silent! call Help_n_Tutorial_and_About_open_Xdg()
endif

if g:osdetected == "Windows"
  function! GIT_SSH_GPG_open_Windows_Explorer()
    :silent! !explorer "https://cutt.ly/4kZVSxP"
  endfun

  :amenu Help.GIT-SSH-GPG\ \(\:HelpSSHnGPG\) :call GIT_SSH_GPG_open_Windows_Explorer() <Esc>
  command! HelpSSHnGPG :call GIT_SSH_GPG_open_Windows_Explorer()

elseif g:osdetected == "Linux"
  " https://askubuntu.com/questions/15354/how-to-open-file-with-default-application-from-command-line#:~:text=is%20not%20useful-,Show%20activity%20on%20this%20post.,in%20the%20user's%20preferred%20application.
  function! GIT_SSH_GPG_open_Xdg()
    :silent!!xdg-open "https://cutt.ly/4kZVSxP" &
    if !has("gui_running")
      :source ~/.vimrc
      :source ~/.vimdotcommon/.vimrc2.vim
      :source ~/.vim/plugin/temporary.vim
    endif
  endfun

  :amenu Help.GIT-SSH-GPG\ \(\:HelpSSHnGPG\) :call GIT_SSH_GPG_open_Xdg() <Esc>
  command! HelpSSHnGPG :silent! call GIT_SSH_GPG_open_Xdg()
endif
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ============================================================================
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ============================================
""     setting up a dark colorscheme at startup (Terminal)

" https://vi.stackexchange.com/questions/30987/check-if-vim-is-opened-in-tty
if $TERM == 'linux'
  set background=dark
  colo murphy
elseif !has("gui_running")
  " NOTE: ctermbg problem: Load palenight first in Linux before loading tokyonight
  colo palenight
  colo tokyonight
endif
" ============================================

"  ===========================================================
"  ===========================================================
"                  TEMPORARY SETTINGS
"  ===========================================================
"  ================== All the temporary settings has been stored in
"                     $HOME/.vim/plugin/temporary.vim
"                     It has to be loaded first, just after the .vimrc
"  ===========================================================

if g:osdetected == "Windows"
  source $HOME/\.vim/plugin/temporary.vim
elseif g:osdetected != "Windows"
  source $HOME/.vim/plugin/temporary.vim
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" add current directory's generated tags file to available tags
set tags+=./tags
set tags+=./tags;/
set tags+=./tags;/.
set path+=./;/

" =======================================================================
