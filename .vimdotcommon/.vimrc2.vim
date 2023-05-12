" Last Change: 2021-02-14  Sunday: 03:55:34 PM
" ============================================
" Write the following line to your _vimrc or .vimrc and uncomment the line
" source $HOME\/\.vimrc2.vim


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
" https://stackoverflow.com/questions/17761819/starting-vim-with-vimfiles-in-a-certain-location
source $HOME\/\.vimdotcommon\/\.viminit


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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Some code folding ~~ <F8> or <Shift+F8> or <Space> ~~~
:amenu Settings.Code\ Folding:\ <F8>=za\ OR\ <Shift+F8>=zR\ OR\ <Space>=zf\ \(\Menu\ Header\) <Esc>

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
inoremap <F8> <C-O>za
nnoremap <F8> za
onoremap <F8> <C-C>za
vnoremap <F8> zf
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

inoremap <S-F8> <C-O>zR
nnoremap <S-F8> zR
onoremap <S-F8> <C-C>zR

"  ==============================================================CODE FOLDING==========================================
"  ====================================================================================================================

" Folding via syntax is used for this filetype.
setlocal foldmethod=syntax

" VIM's command window ('q:') and the :options window also set filetype=vim. We
" do not want folding in these enabled by default, though, because some
" malformed :if, :function, ... commands would fold away everything from the
" malformed command until the last command.
if bufname('') =~# '^\%(' . (v:version < 702 ? 'command-line' : '\[Command Line\]') . '\|option-window\)$'
  " With this, folding can still be enabled easily via any zm, zc, zi, ...
  " command.
  setlocal nofoldenable
else
  " Fold settings for ordinary windows.
  setlocal foldcolumn=4
endif
" The default Vim syntax file has limited 'fold' definitions, so define more.

" define groups that cannot contain the start of a fold
syn cluster vimNoFold contains=vimComment,vimLineComment,vimCommentString,vimString,vimSynKeyRegion,vimSynRegPat,vimPatRegion,vimMapLhs,vimOperParen,@EmbeddedScript
syn cluster vimEmbeddedScript contains=vimMzSchemeRegion,vimTclRegion,vimPythonRegion,vimRubyRegion,vimPerlRegion

" fold while loops
syn region vimFoldWhile
      \ start="\<wh\%[ile]\>"
      \ end="\<endw\%[hile]\>"
      \ transparent fold
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

" fold for loops
syn region vimFoldFor
      \ start="\v<for>%(\s*\n\s*\\)?\s*\k+%(\s*\n\s*\\\s*)?\s*<in>"
      \ end="\<endfo\%[r]\>"
      \ transparent fold
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

" fold if...else...endif constructs
"
" note that 'endif' has a shorthand which can also match many other end patterns
" if we did not include the word boundary \> pattern, and also it may match
" syntax end=/pattern/ elements, so we must explicitly exclude these
syn region vimFoldIfContainer
      \ start="\<if\>"
      \ end="\<en\%[dif]\>=\@!"
      \ transparent
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ contains=NONE
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldIf
      \ start="\<if\>"
      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldIfContainer
      \ nextgroup=vimFoldElseIf,vimFoldElse
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldElseIf
      \ start="\<else\%[if]\>"
      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldIfContainer
      \ nextgroup=vimFoldElseIf,vimFoldElse
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldElse
      \ start="\<el\%[se]\>"
      \ end="\<en\%[dif]\>=\@!"
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldIfContainer
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

" fold try...catch...finally...endtry constructs
syn region vimFoldTryContainer
      \ start="\<try\>"
      \ end="\<endt\%[ry]\>"
      \ transparent
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ contains=NONE
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldTry
      \ start="\<try\>"
      \ end="^\s*\\\?\s*\(fina\%[lly]\|cat\%[ch]\)\>"ms=s-1,me=s-1
        \ fold transparent
        \ keepend
        \ contained containedin=vimFoldTryContainer
        \ nextgroup=vimFoldCatch,vimFoldFinally
        \ contains=TOP
        \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldCatch
      \ start="\<cat\%[ch]\>"
      \ end="^\s*\\\?\s*\(cat\%[ch]\|fina\%[lly]\)\>"ms=s-1,me=s-1
        \ fold transparent
        \ keepend
        \ contained containedin=vimFoldTryContainer
        \ nextgroup=vimFoldCatch,vimFoldFinally
        \ contains=TOP
        \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldFinally
      \ start="\<fina\%[lly]\>"
      \ end="\<endt\%[ry]\>"
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldTryContainer
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

" Folding of functions and augroups is built-in since VIM 7.2 (it was introduced
" with vim.vim version 7.1-76) if g:vimsyn_folding contains 'a' and 'f', so set
" this variable if you want it. (Also in older VIM versions.)
if v:version <= 701 && exists('g:vimsyn_folding')
  " Starting with VIM 7.2, this is built-in. Retrofit for older versions unless
  " VIM 7.1 already has it patched in.
  let s:vimsyn_folding = g:vimsyn_folding
  if v:version => 701
    " Special check for VIM 7.1: Since we cannot check for that particular
    " version of the runtime file, check one of the associated group names
    " itself for the 'fold' keyword.
    redir => s:synoutput
    silent! syn list vimFuncBody
    redir END
    if s:synoutput =~ 'fold'
      " No need to retrofit, this vim.vim version already supports folding.
      let s:vimsyn_folding = ''
    endif
    unlet s:synoutput
  endif

  if s:vimsyn_folding =~# 'f'
    " fold functions
    syn region vimFoldFunction
          \ start="\<fu\%[nction]!\=\s\+\%(<[sS][iI][dD]>\|[sSgGbBwWtTlL]:\)\?\%(\i\|[#.]\|{.\{-1,}}\)*\ze\s*("
          \ end="\<endfu\%[nction]\>"
          \ transparent fold
          \ keepend extend
          \ containedin=ALLBUT,@vimNoFold
          \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
  endif

  " fold augroups
  if s:vimsyn_folding =~# 'a'
    syn region vimFoldAugroup
          \ start="\<aug\%[roup]\ze\s\+\(END\>\)\@!"
          \ end="\<aug\%[roup]\s\+END\>"
          \ transparent fold
          \ keepend extend
          \ containedin=ALLBUT,@vimNoFold
          \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
  endif
  unlet s:vimsyn_folding
endif

"  ==============================================================CODE FOLDING ENDS=====================================
"  ====================================================================================================================


"  ==============================================================CODE FOLDING 2==========================================
"  ======================================================================================================================
" Enable Code Folding
setlocal foldmethod=syntax
set foldcolumn=5
set mouse=a
" the number of columns to use for folding display at the left

" set indent guides
:match Search /\%(\_^\s*\)\@<=\%(\%1v\|\%5v\|\%9v\)\s/
function! ToggleIndentGuides()
  if exists('b:indent_guides')
    call matchdelete(b:indent_guides)
    unlet b:indent_guides
  else
    let pos = range(1, &l:textwidth, &l:shiftwidth)
    call map(pos, '"\\%" . v:val . "v"')
    let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'
    let b:indent_guides = matchadd('CursorLine', pat)
  endif
endfunction

"  ==============================================================CODE FOLDING 2 ENDS===================================
"  ====================================================================================================================

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" CTRL-F is Find
noremap <C-F> :promptfind <CR><Esc><CR>
" CTRL-H is Find and Replace
noremap <C-H> :promptrepl <CR><Esc><CR>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"                 More useful statusline
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%3{codeium#GetStatusString()}             "Codeium: https://codeium.com/
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction
hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe
"                 End of More useful statusline with colours
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has("gui_running")
  "   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "                       Setting for Coloured Statusline and the line col highlight feature
  "                       Highlight current line and column
  :set cursorline
  :set cursorcolumn

  "   :redir => cursorline_highlight | silent highlight CursorLine | redir END
  "   :echo "CursorLine highlight: " . cursorline_highlight
  :highlight CursorLine  term=underline  guibg=#fffcd0  cterm=underline

  "   :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
  "   :echo "CursorColumn highlight: " . cursorcolumn_highlight
  :highlight CursorColumn  term=underline  guibg=#e1ffd5  cterm=underline


  "   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "                       Setting for Coloured Statusline and the line-col highlight feature

  :amenu Settings.-Sep0-  :
  :nmenu Settings.Restore\ Coloured\ Status\ Line\ \ \ \ \ \ \:\call\ ColStline(\)\ \ \ or\ \ \ \ \ \ \\cst :call ColStline() <ESC>
  nnoremap <Leader>cst :call ColStline()<cr>
  vnoremap <Leader>cst :call ColStline()<cr>
  inoremap <Leader>cst <Esc><Esc>:call ColStline()<cr>


  :amenu Settings.Highlight\ Line\ and\ column\ ON-OFF\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \\hl   :call ToggleHighlightLineColumn()<cr>


  nnoremap <Leader>hl :call ToggleHighlightLineColumn()<cr>
  vnoremap <Leader>hl :call ToggleHighlightLineColumn()<cr>
  inoremap <Leader>hl <Esc><Esc>:call ToggleHighlightLineColumn()<cr>

endif

"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
if has("gui_running")
  "                       Function for the Coloured Statusline
  fun! ColStline()
    hi User1 guifg=#ffdad8  guibg=#880c0e
    hi User2 guifg=#000000  guibg=#F4905C
    hi User3 guifg=#292b00  guibg=#f4f597
    hi User4 guifg=#112605  guibg=#aefe7B
    hi User5 guifg=#051d00  guibg=#7dcc7d
    hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
    hi User8 guifg=#ffffff  guibg=#5b7fbb
    hi User9 guifg=#ffffff  guibg=#810085
    hi User0 guifg=#ffffff  guibg=#094afe
  endfun
endif
"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                       Function for the line-col highlight feature
if has("gui_running")
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

endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Setting up the directories {
"" Backup directories can be created from the temporary.vim plugin.
" Look at the plugin folder for the file temporary.vim containing the same lines.
"" Creating directories if they don't exist
" silent execute '!mkdir "'.$HOME.'/.vimbackup"'
" silent execute '!mkdir "'.$HOME.'/.vimswap"'
" silent execute '!mkdir "'.$HOME.'/.vimviews"'
" silent execute '!mkdir "'.$HOME.'/.vimundo"'

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
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has("gui_running")
  " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ " " " Color scheme
  "   ~~~~====================================COLOUR SCHEME====================================~~~~~
  " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "  ======================================================
  "  Separator
  "  ======================================================
  :menu Settings.-Sep1-   :

  "                                    Setting for some Modified Default colour schemes, you will find more later
  :amenu Settings.Modified\ Default\ Themes.default\ <Alt-Shift-F11> :call <SID>ThemeDefault() <CR>
  map <M-S-F11> :call <SID>ThemeDefault() <CR>
  :amenu Settings.Modified\ Installed\ Themes.MustangGreen\ <Ctrl-Shift-F11> :call ColourMustangGreen() <CR>

  map <C-S-F11> :call ColourMustangGreen() <CR>
  fun! ColourMustangGreen()
    if g:osdetected == "Windows"
      colors Mustang_Green
    elseif g:osdetected == "Linux"
      colors mustang_green
      "elseif g:osdetected == "Unix"
      "colors mustang_green
    endif

    call ColStline()
    :set cursorline
    :set cursorcolumn
    " :redir => cursorline_highlight | silent highlight CursorLine | redir END
    " :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    " :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    " :highlight MatchParen  term=underline  guibg=#000000  guifg=#f16700  cterm=underline
    " :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Installed\ Themes.Mustang :call ColourMustang() <CR>
  fun! ColourMustang()
    if g:osdetected == "Windows"
      colors Mustang
    elseif g:osdetected == "Linux"
      colors mustang
      "elseif g:osdetected == "Unix"
      "colors mustang
    endif

    call ColStline()
    :set cursorline
    :set cursorcolumn
    " :redir => cursorline_highlight | silent highlight CursorLine | redir END
    " :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    " :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    " :highlight MatchParen  term=underline  guibg=#000000  guifg=#f16700  cterm=underline
    " :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ " " " Color scheme

  "                       Another function for Highlighting current line and column with coloured status line
  "                       when resuming default theme

  fun! <SID>ThemeDefault()
    if g:osdetected == "Windows"
      colors default
    elseif g:osdetected == "Linux"
      colors default
      "elseif g:osdetected == "Unix"
      "colors default
    endif



    :hi ColorColumn ctermbg=lightgrey guibg=lightgrey
    hi User1 guifg=#ffdad8  guibg=#880c0e
    hi User2 guifg=#000000  guibg=#F4905C
    hi User3 guifg=#292b00  guibg=#f4f597
    hi User4 guifg=#112605  guibg=#aefe7B
    hi User5 guifg=#051d00  guibg=#7dcc7d
    hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
    hi User8 guifg=#ffffff  guibg=#5b7fbb
    hi User9 guifg=#ffffff  guibg=#810085
    hi User0 guifg=#ffffff  guibg=#094afe
    call ColStline()
    :set cursorline
    :set cursorcolumn
    "   :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#fffcd0  cterm=underline
    "   :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight CursorColumn  term=underline  guibg=#e1ffd5  cterm=underline
    " autocomplete menu
    " https://bbs.archlinux.org/viewtopic.php?id=139163
    highlight Pmenu guifg=black guibg=darkolivegreen1
    highlight PmenuSel guifg=white guibg=darkslategray
  endfun


  "                       Setting for Modified Default Coloured Themes, "   some colour scheme continued
  :amenu Settings.Modified\ Default\ Themes.blue :call Colourblue() <CR>
  fun! Colourblue()
    colors blue
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#002780  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=yellow  guifg=red  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#003080  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.delek :call Colourdelek() <CR>
  fun! Colourdelek()
    colors delek
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#000055  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=yellow  guifg=red  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#110068  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.darkblue :call Colourdarkblue() <CR>
  fun! Colourdarkblue()
    colors darkblue
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#000055  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=yellow  guifg=red  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#110068  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.desert :call Colourdesert() <CR>
  fun! Colourdesert()
    colors desert
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.elflord :call Colourelflord() <CR>
  fun! Colourelflord()
    colors elflord
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.evening :call Coloureevening() <CR>
  fun! Coloureevening()
    colors evening
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.industry :call Coloureindustry() <CR>
  fun! Coloureindustry()
    colors industry
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.koehler :call Colourkoehler() <CR>
  fun! Colourkoehler()
    colors koehler
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.morning :call Colourmorning() <CR>
  fun! Colourmorning()
    colors morning
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#170101  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#191818  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.murphy :call Colourmurphy() <CR>
  fun! Colourmurphy()
    colors murphy
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#1e1e1e  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#f16700  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#232323  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.pablo :call Colourpablo() <CR>
  fun! Colourpablo()
    colors pablo
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#1e1e1e  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ff5500  guifg=#ffff00  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#232323  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.peachpuff :call Colourpeachpuff() <CR>
  fun! Colourpeachpuff()
    colors peachpuff
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#ffd2fb  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#ff5500  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#d9e3ff  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.ron :call Colourron() <CR>
  fun! Colourron()
    colors ron
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#ffd2fb  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#ff5500  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#d9e3ff  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.shine :call Colourshine() <CR>
  fun! Colourshine()
    colors shine
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#ffd2fb  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#ff5500  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#d9e3ff  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.slate :call Colourslate() <CR>
  fun! Colourslate()
    colors slate
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#ffd2fb  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#ff5500  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#d9e3ff  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.torte :call Colourtorte() <CR>
  fun! Colourtorte()
    colors torte
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#ffd2fb  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#ff5500  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#d9e3ff  cterm=underline
  endfun

  :amenu Settings.Modified\ Default\ Themes.zellner :call Colourzellner() <CR>
  fun! Colourzellner()
    colors zellner
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#ffd2fb  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight MatchParen  term=underline  guibg=#ffff00  guifg=#ff5500  cterm=underline
    :highlight CursorColumn  term=underline  guibg=#d9e3ff  cterm=underline
  endfun

  :amenu Settings.Modified\ Installed\ Themes.oh-la-la :call Colourohlala() <CR>
  fun! Colourohlala()
    colors oh-la-la
    call ColStline()
    :set cursorline
    :set cursorcolumn
    :redir => cursorline_highlight | silent highlight CursorLine | redir END
    :highlight CursorLine  term=underline  guibg=#1e1e1e  cterm=underline
    :redir => cursorcolumn_highlight | silent highlight CursorColumn | redir END
    :highlight CursorColumn  term=underline  guibg=#232323  cterm=underline
  endfun

  "  =====================================================================================================END OF MODIFIED COLOUR SCHEMES
  "  ===================================================================================================================================

  "  ===================================================================================================================================
  " autocomplete menu
  " https://bbs.archlinux.org/viewtopic.php?id=139163
  " http://codeyarns.com/2011/07/29/vim-chart-of-color-names/
  "  ===================================================================================================================================
  " highlight Pmenu ctermfg=<color> ctermbg=<color>
  highlight Pmenu guifg=black guibg=darkolivegreen1
  " highlight PmenuSel ctermfg=<color> ctermbg=<color>
  highlight PmenuSel guifg=white guibg=darkslategray

endif
"  ===================================================================================================================================


"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   ~~~~~~~~~~~~~~~====================================SOME USEFUL UTILITIES MENU==========~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Remember the 'ampersand' operator '&' means open the application but detach it from vim
"   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if has("gui_running")
  " Opens Explorer
  if g:osdetected == "Windows"
    :amenu Utilities.Explorer\.exe :!start Explorer.exe <CR><Esc><CR>
    " Locates in the Explorer, XP only
    :amenu Utilities.Locate\ in\ Explorer\ (\XP\ only\) :silent !start explorer /e,,%:p:h,/select,%:p <CR><Esc><CR>
    " Open Containing Folder XP, Win7
    :amenu Utilities.Open\ Containing\ Folder\ (\XP\,\ Win7\) :silent !start explorer %:p:h<Esc>
  endif

  " Opens Directory via console
  if g:osdetected == "Windows"
    :amenu Utilities.Open\ Directory\ via\ Console :silent !start cmd.exe /k pushd %:p:h <CR><Esc><CR>
  endif

  " Opens Directory via NERDTree Plugin
  :amenu Utilities.Open\ Directory\ via\ NERDTree\ Plugin :NERDTree %:p:h <CR><Esc><CR>
  " Put NERDTree to Command
  :amenu Utilities.Put\ NERDTree\ to\ Command\ Mode :NERDTree
  " Put NERDTreeToggle
  :amenu Utilities.NERDTreeToggle :NERDTreeToggle<CR>

  " Opens Directory via CocExplorer Plugin
  :amenu Utilities.Open\ Directory\ via\ CocExplorer\ Plugin\ \(<space>e\ or,\ \:\CocCommand\ explorer\) :CocCommand explorer<CR><Esc><CR>

  " Goyo - Distraction-free mode
  :amenu Utilities.Goyo\ \(\:\Goyo\)\ \(\to\ exit,\ \:\Goyo!\) :Goyo<CR><Esc><CR>

  " Opens Useful Apps and Programs
  if g:osdetected == "Windows"
    :amenu Utilities.notepad :silent!!start "notepad.exe" <CR><Esc><CR>
    :amenu Utilities.Open\ with\ notepad :silent !start "notepad.exe" "%:p" <CR><Esc><CR>
    :amenu Utilities.Notepad++ :silent!!start /min cmd /c "C:\Program Files\Notepad++\notepad++.exe" <CR><Esc><CR>
    :amenu Utilities.Open\ with\ Notepad++ :silent !start "C:\Program Files\Notepad++\notepad++.exe" "%:p" <CR><Esc><CR>
    :amenu Utilities.Notepad2-mod :silent!!start /min cmd /c "C:\Program Files\Notepad2\Notepad2.exe" <CR><Esc><CR>
    :amenu Utilities.Open\ with\ Notepad2-mod :silent !start "C:\Program Files\Notepad2\Notepad2.exe" "%:p" <CR><Esc><CR>
    fun Win_calculator()
      :silent!!start "calc" <Esc>
    endfun
    :amenu Utilities.Calculator :call Win_calculator() <CR><Esc><CR>


    " Open File with Default Application
    :amenu Utilities.Open\ File\ with\ Default\ Application :silent! !explorer "%:p" <Esc>

  elseif g:osdetected == "Linux"
    " how to open file manager in linux from terminal
    " https://www.unixmen.com/open-system-file-manager-terminal
    " how to open default calculator in linux from terminal
    " https://askubuntu.com/questions/628026/how-to-launch-the-calculator-through-terminal
    " man -k calculator
    " man -k camera

    :amenu Utilities.Open\ File\ with\ Default\ Application\ (\LINUX\ only\) :call Open_File_with_Default_Application() <CR><Esc><CR>
    :amenu Utilities.Explore\ Current\ File's\ Directory\ (\LINUX\ only\) :call Explore_file_PWD() <CR><Esc><CR>
    :amenu Utilities.kitty\ Terminal\ Emulator :call Kitty_Terminal_Emulator() <CR><Esc><CR>
    :amenu Utilities.Open\ Current\ File's\ Directory\ via\ kitty-terminal :call Kitty_Terminal_current_file_s_dir() <CR><Esc><CR>
    :amenu Utilities.Open\ Current\ File's\ Directory\ via\ Sakura\ Terminal\ Emulator :call Sakura_Terminal_current_file_s_dir() <CR><Esc><CR>
    :amenu Utilities.Open\ Current\ File's\ Directory\ via\ GITK\ GIT\ Client :call GITK() <CR><Esc><CR>
    :amenu Utilities.Open\ Current\ File's\ Directory\ via\ Giggle\ GIT\ Client :call Giggle() <CR><Esc><CR>
    :amenu Utilities.Open\ dir\ tree\ with\ Data\ Display\ Debugger\ (\DDD\) :call Data_Display_Debugger_in_th_current_file_s_dir() <CR><Esc><CR>
    :amenu Utilities.xedit :call Xedit_open() <CR><Esc><CR>
    :amenu Utilities.Open\ with\ xedit :call Open_w_Xedit() <CR><Esc><CR>
    :amenu Utilities.Geany :call Geany_open() <CR><Esc><CR>
    :amenu Utilities.Open\ with\ Geany :call Open_w_Geany() <CR><Esc><CR>
    :amenu Utilities.Open\ meld\ (\file\ compare\ utility\) :call Meld_diff_viewer() <CR><Esc><CR>
    :amenu Utilities.Open\ w\ meld\ one\ side\ (\file\ compare\ utility\) :call Open_w_Meld_diff_viewer_One_side() <CR><Esc><CR>

    " ---------------------------------------------- install 'cdecl' and 'cutils' first,
    " sudo apt install cdecl
    " sudo apt install cutils

    :amenu Utilities.cdecl\ explain\ (\C\ pointer\ gibberish\ to\ plain\ English\)\ (\like:\ cdecl\ explain\ "int\ *p"\) :!cdecl explain "
    :amenu Utilities.cdecl\ declare\ (\English\ to\ C\)\ (\like:\ cdecl\ declare\ "p\ as\ pointer\ to\ int"\) :!cdecl declare "
    " ------------------------------------------------------------------------------------

    fun! Xedit_open()
      :silent!!xedit &
    endfun
    fun! Open_w_Xedit()
      :!xedit % &
    endfun
    fun! Geany_open()
      :silent!!geany &
    endfun
    fun! Open_w_Geany()
      :!geany % &
    endfun
    fun! Meld_diff_viewer()
      :silent!!meld &
    endfun
    fun! Open_w_Meld_diff_viewer_One_side()
      :!meld % &
    endfun
    fun! Kitty_Terminal_Emulator()
      :silent!!kitty &
    endfun
    function! Data_Display_Debugger_in_th_current_file_s_dir()
      let curr_dir = expand('%:h')
      if curr_dir == ''
        let curr_dir = '.'
      endif
      :cd %:h
      :!ddd -d "$PWD" &
      execute 'lcd -'
      " :copen
    endfunction
    fun! Open_File_with_Default_Application()
      :!xdg-open "%:p" &
    endfun
    function! Kitty_Terminal_current_file_s_dir()
      let curr_dir = expand('%:h')
      if curr_dir == ''
        let curr_dir = '.'
      endif
      :cd %:h
      :!kitty -d "$PWD" &
      " Failed to launch child: /home With error: Permission denied Press Enter to exit. Kitty Terminal
      " https://github.com/kovidgoyal/kitty/issues/1930
      execute 'lcd -'
      " :copen
    endfunction
    function! Sakura_Terminal_current_file_s_dir()
      let curr_dir = expand('%:h')
      if curr_dir == ''
        let curr_dir = '.'
      endif
      :cd %:h
      :!sakura -d "$PWD" &
      execute 'lcd -'
      " :copen
    endfunction
    function! GITK()
      let curr_dir = expand('%:h')
      if curr_dir == ''
        let curr_dir = '.'
      endif
      :cd %:h
      :!gitk -d "$PWD" &
      execute 'lcd -'
      " :copen
    endfunction
    function! Giggle()
      let curr_dir = expand('%:h')
      if curr_dir == ''
        let curr_dir = '.'
      endif
      :cd %:h
      :!giggle -d "$PWD" &
      execute 'lcd -'
      " :copen
    endfunction
    function! Explore_file_PWD()
      let curr_dir = expand('%:h')
      if curr_dir == ''
        let curr_dir = '.'
      endif
      :cd %:h
      :!xdg-open "$PWD" &
      execute 'lcd -'
      " :copen
    endfunction

  endif

endif
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
  :amenu Utilities.Copy\ pwd\ to\ System\ Clipboard\ (\:Pwdtoclip\) :call CopyPWDToWindowsNMacOSXClipboard() <CR><Esc><CR>
  command! Pwdtoclip :call CopyPWDToWindowsNMacOSXClipboard()
elseif (g:osdetected == "Linux")
  :amenu Utilities.Copy\ pwd\ to\ Linux\ Clipboard\ (\:Pwdtoclip\) :call CopyPWDToLinuxClipboard() <CR><Esc><CR>
  command! Pwdtoclip :call CopyPWDToLinuxClipboard()
else
  :amenu Utilities.Copy\ pwd\ to\ System\ Clipboard\ (\:Pwdtoclip\) :call CopyPWDToSystemClipboard() <CR><Esc><CR>
  command! Pwdtoclip :call CopyPWDToSystemClipboard()
endif
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
:amenu Plugin.-Sep0-  :
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.LanguageTool\ Grammar\ Check\ (\:GrammarousCheck\) :GrammarousCheck <CR><Esc>
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.-Sep1-  :
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.British/American.LanguageTool\ Grammar\ Check\ (\:GrammarousCheck\ --lang=en-gb\ --preview\ --comments-only\) :GrammarousCheck --lang=en-gb --preview --comments-only <CR><Esc>
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.British/American.LanguageTool\ Grammar\ Check\ (\:GrammarousCheck\ --lang=en-us\ --preview\ --comments-only\) :GrammarousCheck --lang=en-us --preview --comments-only <CR><Esc>
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.-Sep2-  :
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.LanguageTool\ Grammar\ Check\ Reset\ (\:GrammarousReset\) :GrammarousReset <CR><Esc>
:amenu Plugin.Spelling\ and\ Grammar\ in\ Comments.LanguageTool\ Grammar\ Check\ Help :GrammarousCheck --help <CR>
:amenu Plugin.-Sep1-  :
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Discard Changes and Exit GVim
:amenu File.Discard\ Changes\ and\ Exit\ GVim\ [\Exit\ Anyway\]\ (\:q!\) :q! <CR>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Force-Overwrite Read-Only Files
:amenu File.Force-Overwrite\ Read-Only\ Files\ (\:w!\) :w! <CR>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Remove Duplicate Lines
:amenu Utilities.Remove\ Duplicate\ Lines\ \[*Warning*:\ For\ lists\.\ Do\ not\ run\ it\ on\ codes\.\]\ (\:sort\ u\) :sort u <CR>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Trim Trailling Whitespace
:amenu Utilities.Trim\ Trailling\ Whitespace :call <SID>StripWhite() <CR>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" :h GUI or :help sub-menu-priority
if has("gui_running")
  if g:osdetected == "Windows"
    :tmenu icon=$HOME/\.vim/bitmaps/new.bmp 1.400 ToolBar.NewFile New File
    :amenu ToolBar.NewFile :confirm enew <cr>
    :tmenu icon=$HOME/\.vim/bitmaps/saveas.bmp 1.410 ToolBar.SaveAs Save As
    :amenu ToolBar.SaveAs :browse confirm saveas <cr>
    :tmenu icon=$HOME/\.vim/bitmaps/calc.bmp 1.420 ToolBar.Calculator Calculator
    :amenu ToolBar.Calculator :silent!!calc.exe <CR><Esc><CR>

  elseif g:osdetected == "Linux"
    :tmenu icon=$HOME/.vim/bitmaps/new.bmp 1.400 ToolBar.NewFile New File
    :amenu ToolBar.NewFile :confirm enew <cr>
    :tmenu icon=$HOME/.vim/bitmaps/saveas.bmp 1.410 ToolBar.SaveAs Save As
    :amenu ToolBar.SaveAs :browse confirm saveas <cr>
    :tmenu icon=$HOME/.vim/bitmaps/calc.bmp 1.420 ToolBar.Calculator Calculator
    :amenu ToolBar.Calculator :call X_window_System_Calculator() <CR><Esc><CR>

    fun! X_window_System_Calculator()
      :silent!!xcalc &
    endfun
  endif
endif

if g:osdetected == "Windows"
  :tmenu icon=$HOME/.vim/bitmaps/bufferdelete.bmp 1.415 ToolBar.bufferdelete Buffer Delete (close file) (:confirm bd)
elseif g:osdetected != "Windows"
  :tmenu icon=$HOME/.vim/bitmaps/bufferdelete.bmp 1.415 ToolBar.bufferdelete Buffer Delete (close file) (:confirm bd)
endif
:amenu ToolBar.bufferdelete :confirm bd <Esc>

" ====================================
" ============= Insert Filename ======
" ====================================
:amenu Insert.Insert\ Filename\ <\S\-F3\> :put =expand('%:t')<Esc>
:amenu Insert.Insert\ Filename\ with\ Full\ Path :put =expand('%:p')<Esc>
" "            https://vi.stackexchange.com/questions/23348/how-to-save-file-with-todays-date
" "            https://vi.stackexchange.com/questions/12221/automatically-insert-timestamp-when-opening-certain-file
:amenu Insert.Insert\ Date :put =strftime('%F')<Esc>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nmap <S-F3> a<C-R>= expand('%:t')<Esc>
imap <S-F3> <C-R>= expand('%:t')<Esc>
" ====================================
" ====================================

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

" ====================================
" ========= vim-wipeout setup =======
" ====================================
:amenu Plugin.:Wipeout :Wipeout <CR><Esc>
" ====================================

" ========= TagbarToggle setup =======
" ====================================
:amenu Plugin.:TagbarToggle :TagbarToggle <CR><Esc>
" ====================================

" ========= Vista Toggle setup =======
" ====================================
:amenu Plugin.:Vista!! :Vista!! <CR><Esc>
" ====================================

" ====================================
" ========= stlrefvim setup =======
" ====================================
:amenu Plugin.:h\ stlrefvim :h stlrefvim <CR><Esc>
" ====================================

" ====================================
" ========= crefvim setup =======
" ====================================
:amenu Plugin.:h\ crefvim :h crefvim <CR><Esc>
" ====================================

" ====================================
" ========= TaskList setup =======
" ====================================
:amenu Plugin.:TaskList\ \(\TODO,\ FIXME,\ XXX\)\ \(or,\ <\Leader\>\t\ then\ Esc\ and\ q\ to\ quit\) :TaskList <CR><Esc>
" ====================================

" ====================================
" ========= DetectIndent setup =======
" ====================================
:menu Plugin.DetectIndent:-\ \ \ \ :\DetectIndent   :<Esc>:<Esc>:DetectIndent<Cr>
" ====================================

" ====================================
" ========= BetterSearch setup =======
" ====================================
:amenu Plugin.-Sep2-  :
:amenu Plugin.BetterSearch.BetterSearchChangeHighlight :BetterSearchChangeHighlight
:amenu Plugin.BetterSearch.BetterSearchCloseWin :BetterSearchCloseWin <CR>
:amenu Plugin.BetterSearch.BetterSearchCopyToClipBoard :BetterSearchCopyToClipBoard <CR>
:amenu Plugin.BetterSearch.BetterSearchHighlighToggle :BetterSearchHighlighToggle <CR>
:amenu Plugin.BetterSearch.BetterSearchHighlightLimit :BetterSearchHighlightLimit
:amenu Plugin.BetterSearch.BetterSearchPromptOn :BetterSearchPromptOn <CR>
:amenu Plugin.BetterSearch.BetterSearchSwitchWin :BetterSearchSwitchWin <CR>
:amenu Plugin.BetterSearch.BetterSearchVisualSelect :BetterSearchVisualSelect <CR>
:amenu Plugin.-Sep3-  :
" ====================================

"  ======================================================
" ~~~~~~~~~~~ YankRing plugin Configuration ~~~~~~
:nnoremap <silent> <C-F11> :YRShow<CR>
function! YRRunAfterMaps()
  nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction
" ~~~~~~~~~~~ YankRing plugin Configuration ends ~~~~~~


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
" ------------------------------- Common Tags-----------
" https://vi.stackexchange.com/questions/2572/detect-os-in-vimscript
if has("win64") || has("win32") || has("win16") || has("win32unix")
  source $HOME\/\.vimdotwin\/\tagspath.txt
else
  source $HOME\/\.vimdotlinux\/\tagspath.txt
endif


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

" ******************************************************************************
" ******************************************************************************
" ******************************************************************************
" ******************************************************************************
" ====== AUTOCOMPLETION+CODE_CHECKING PLUGIN CHOICES ===========================
" ==============================================================================

" ============== CHOICE ONE ==============================
" ============== NOTE: Install Node.js first
" ======================and add Node executable to System Path
" ============== https://nodejs.org/en/download/
" ============== UBUNTU ==================
" # Using Ubuntu
" sudo apt install clangd
" sudo apt install curl
" curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
" sudo apt-get install -y nodejs
" ============== https://github.com/nodesource/distributions/blob/master/README.md
" ============== MSYS2:
" https://github.com/msys2/MINGW-packages/issues/4788
" ===== Dnld the ZIP. Extract to "C:\msys64\opt\"
" export PATH=/opt/node-v14.17.5-win-x64/:$PATH >> ~/.bash_profile
" <WINDOWS+R> ---> systempropertiesadvanced ---> Advanced ---> Environment Variables ---> System Variables ---> Path ---> Edit ---> New ---> Paste the location from the clipboard (C:\msys64\opt\node-v14.17.5-win-x64)

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kevinoid/vim-jsonc'
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
" ====== RUSTC/Cargo Support
Plug 'rust-lang/rust.vim'
" https://blog.logrocket.com/configuring-vim-rust-development/#rust-analyzer
" MS Windows 10 x64
" pacman -S mingw-w64-x86_64-rust
" pacman -S mingw-w64-x86_64-cargo-c
" Or
" https://forge.rust-lang.org/infra/other-installation-methods.html
" x86_64-pc-windows-gnu
" ************ AFTER INSTALLATION:
" :CocInstall coc-json
" :CocInstall coc-clangd
" :CocInstall coc-tabnine
" :CocInstall coc-snippets
" :CocInstall coc-diagnostic
" :CocInstall coc-lightbulb
" :CocInstall coc-tasks
" :CocInstall coc-rust-analyzer
" :CocConfig
"         Then, paste the line below (without comments) in the new file.
"                                 "diagnostic.displayByAle": true
" ============== (END) CHOICE ONE ========================

" ==================== CHOICE TWO ========================
" Plug 'https://github.com/justmao945/vim-clang.git'

"                  ------------------------------
"                  Changing windows from a vim function is not allowed anymore, since Vim 8.2.2426,7.
"                  https://github.com/justmao945/vim-clang/pull/140
"                  A fork of vim-clang provided by @mckellygit (https://github.com/mckellygit) can
"                  be adopted as a temporary fix.

"                  Plug 'https://github.com/mckellygit/vim-clang.git'

"                  The issue (https://github.com/justmao945/vim-clang/issues/142#issue-812186251)
"                  has been fixed and the patch committed by @mckellygit has been merged with
"                  the master branch by @justmao945.
"                  ------------------------------

" Plug 'https://github.com/Pinaki82/vim-clang-Settings.git'
" Plug 'https://github.com/Pinaki82/Omni-Completion-at-CTRL-SPACE.git'
" Plug 'https://github.com/vim-scripts/AutoComplPop.git'
Plug 'https://github.com/Pinaki82/code_complete.git'

"                  ------------------- Tabnine
"                 if g:osdetected != "Windows"
"                   " First, open any Linux Terminal in the 'plugged' directory, then
"                   " Run git clone --depth 1 https://github.com/codota/tabnine-vim in your Terminal Emulator
"                   " Now, uncomment the line below (delete the " i.e., the 'double quote') and re-launch GVim
"
"                   " ---------------------------------------------
"                   " Plug 'https://github.com/codota/tabnine-vim'
"                   " ---------------------------------------------
"
"                   set rtp+=$HOME\/\.vim\/\plugged\/\tabnine-vim
"                 endif

" Plug 'https://github.com/vim-syntastic/syntastic.git'
"""" Plug 'https://github.com/Pinaki82/syntastic-warning-window-line-wrap.git'
" ==================== (END) CHOICE TWO ==================

" See the lines after 1660 for coc.nvim and ALE specific settings.
" Disable if needed.

" ==============================================================================
" ====== (END) AUTOCOMPLETION+CODE_CHECKING PLUGIN CHOICES =====================
" ******************************************************************************
" ******************************************************************************
" ******************************************************************************
" ******************************************************************************

" https://vi.stackexchange.com/questions/2094/how-to-make-vimrc-settings-applicable-for-a-directory-tree-only
Plug 'https://github.com/embear/vim-localvimrc.git'

Plug 'https://github.com/preservim/nerdtree.git'

Plug 'https://github.com/vim-scripts/matchparenpp.git'

Plug 'https://github.com/tpope/vim-unimpaired.git'

Plug 'https://github.com/matze/vim-move.git'

Plug 'https://github.com/preservim/nerdcommenter.git'

" ------------------- vimcaps (Linux-only)
if g:osdetected != "Windows"
  Plug 'https://github.com/suxpert/vimcaps.git'
endif

Plug 'https://github.com/vim-scripts/AutoClose.git'

Plug 'https://github.com/Pinaki82/auto-tags-gen.git'

Plug 'https://github.com/WolfgangMehner/vim-plugins.git'

Plug 'https://github.com/lambdalisue/gina.vim.git'

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

if has("gui_running")
  " GUI is running or is about to start.
  " Load MRU only if the GUI is about to load
  Plug 'https://github.com/yegappan/mru.git'
  Plug 'https://github.com/Pinaki82/Vim-MRU-Setup.git'
endif

Plug 'https://github.com/vim-scripts/TaskList.vim.git'

Plug 'https://github.com/preservim/tagbar.git'

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

" ----- https://nickjanetakis.com/blog/writing-and-previewing-markdown-in-real-time-with-vim-8

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'plasticboy/vim-markdown'

" ----- https://nickjanetakis.com/blog/writing-and-previewing-markdown-in-real-time-with-vim-8

Plug 'junegunn/goyo.vim'

Plug 'mhinz/vim-startify' " -- Fancy start screen

Plug 'Exafunction/codeium.vim'
"            C              " Close to GitHub Copilot
"            o            AI Supercharged autocompetion
"            d            Infuse AI into your codeing
"            ium          https://codeium.com/vim_tutorial

"                            === Eye candy third-party Vim colour schemes
Plug 'https://github.com/croaker/mustang-vim.git'

Plug 'https://github.com/Pinaki82/mustang_green-Vim-Colourscheme.git'

Plug 'https://github.com/Pinaki82/oh-la-la.git'

Plug 'https://github.com/tomasr/molokai.git'

Plug 'https://github.com/gosukiwi/vim-atom-dark.git'

" Plug 'chriskempson/base16-vim'

Plug 'jacoborus/tender.vim'

Plug 'arcticicestudio/nord-vim'

Plug 'drewtempelmeyer/palenight.vim'

Plug 'https://github.com/ghifarit53/tokyonight-vim.git'

Plug 'https://github.com/mgutz/vim-colors.git'
"                            === (END) Eye candy third-party Vim colour schemes

" ==================================================
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" like: Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" like: Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" ==================================================

" Initialize plugin system
call plug#end()

" =======================================================================
" ************************ VIM-PLUG PLUGIN SETUP ENDS *******************
" =======================================================================

" =======================================================================

" ------------------- echodoc plugin settings
" To use echodoc, you must increase 'cmdheight' value.
" https://github.com/Shougo/echodoc.vim.git
set cmdheight=2
let g:echodoc_enable_at_startup = 1

" ========================== coc.nvim Specific Options ==========
" ==================== UNCOMMENT the entire coc.nvim SETTINGS if
" ====================== you chose the OPTION TWO for autocompletion and code
" ====================== checking ===============================

" Install missing coc extensions:
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-clangd', 'coc-tabnine', 'coc-diagnostic', 'coc-explorer', 'coc-cmake', 'coc-markdownlint', 'coc-lightbulb', 'coc-tasks', 'coc-rust-analyzer']

" Use CTRL+SPACE for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <C-SPACE>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-SPACE>" :
      \ coc#refresh()
" ALT+SPACE to roll past the autocompletion list backwards
inoremap <expr><M-SPACE> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Open coc explorer: <space>e
:nnoremap <space>e :CocCommand explorer<CR>
" ========================== (END) coc.nvim Specific Options ==========

" ========================== ALE Linter Settings ==========
" ==================== UNCOMMENT the entire ALE Linter SETTINGS if
" ====================== you chose the OPTION TWO for autocompletion and code
" ====================== checking ===============================

let g:ale_c_cppcheck_options = '--enable=all --enable=style --enable=performance --enable=portability --enable=information --enable=unusedFunction --enable=missingInclude --inconclusive --force --suppress=missingIncludeSystem'
let g:ale#statusline#Count = 1
let g:ale#statusline#FirstProblem = 1

let g:ale_set_quickfix = 1

" Map movement through errors without wrapping.
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
" OR map keys to use wrapping.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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

" -----------------------------------------
" 'molokai_original' colour scheme settings (required)
let g:molokai_original = 1
" -----------------------------------------

" -----------------------------------------
" 'plasticboy/vim-markdown' disable code-folding (required)
let g:vim_markdown_folding_disabled = 1
"                        enable LaTeX math
let g:vim_markdown_math = 1
" -----------------------------------------

" -----------------------------------------
" 'plasticboy/vim-markdown' disable code-folding (required)
let g:vim_markdown_folding_disabled = 1
"                        enable LaTeX math
let g:vim_markdown_math = 1
" -----------------------------------------

" -----------------------------------------
" Markdown Preview Plugin Settings
:amenu Markdown.Start\ the\ Preview\ \ \ \ \ \ \:\MarkdownPreview <ESC>:MarkdownPreview <CR>
"                                         Corresponding Position in the Browser
:amenu Markdown.Toggle\ the\ Preview\ \(\Corresponding\ Position\ in\ the\ Browser\)\ \:\MarkdownPreviewToggle <ESC>:MarkdownPreviewToggle <CR>
:amenu Markdown.Stop\ the\ Preview\ \ \ \ \ \ \:\MarkdownPreviewStop <ESC>:MarkdownPreviewStop <CR>
" -----------------------------------------

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
" Launch Cursor AI Editor
" See the instructions at https://github.com/Pinaki82/Tulu-C-IDE/blob/main/Artificial-Intelligence-CLI/README.md.
" sudo rm /usr/local/bin/cursor
" ln -s target_file link_name
" sudo ln -s /path/to/your/appimage/folder/Cursor-0.m.n.AppImage /usr/local/bin/cursor
" Example:
" sudo ln -s ~/PortablePrograms/Cursor-0.1.9.AppImage /usr/local/bin/cursor
"
" On MS Windows, add Cursor's installation folder to the Environment Variable (System PATH).
" On MS Windows, Press the WindowsButton + r,
" type systempropertiesadvanced, and press OK
" Environment Variables... -> System variables -> Path -> Edit... ->
" -> New
" Fill the field with the path containing Cursor.exe.
" Typically, C:\Users\YOUR_USERNAME\AppData\Local\Programs\Cursor\
" Which is, %LOCALAPPDATA%\Programs\Cursor\
" The installer responsible for the installation of the Cursor Editor generally places the program and data in that location.
"
"
if has("gui_running")
  " Runs Cursor AI Editor
  if g:osdetected == "Windows"
    :amenu AI.CursorAIEditor\ \(\:\CursorAIEditor\) :silent!!start "Cursor.exe" <Esc>
    command! CursorAIEditor :silent!!start "Cursor.exe" <Esc>

  elseif g:osdetected == "Linux"
        function! CursorLinuxAppImage()
        	" See the instructions at https://github.com/Pinaki82/Tulu-C-IDE/blob/main/Artificial-Intelligence-CLI/README.md.
        	"
        	:silent!!cursor &
	    endfunction

	command! CursorAIEditor :silent!!cursor &
	:amenu AI.Cursor\ AI\ Editor\ \(\:\CursorAIEditor\) :silent! :call CursorLinuxAppImage() <Esc>
  endif
endif
" -----------------------------------------

" -----------------------------------------
" ChatGPT Console
if has("gui_running")
  " Opens ChatGPT via console
  if g:osdetected == "Windows"
    :amenu AI.Open\ ChatGPT\ Console :silent !start cmd /k chatgpt <Esc>

  elseif g:osdetected == "Linux"
        function! ChatGPTLinux()
        	" Bash shell: which chatgpt
        	" copy the path
        	" command! ChatGPT :silent!!sakura --execute ~/.platformio/penv/bin/chatgpt & " Not required
        	"
        	set shell=bash\ -i
        	"command! ChatGPT :silent! :!/usr/bin/sakura --execute chatgpt &
        	:silent! :!/usr/bin/sakura --execute chatgpt &
	    endfunction
	set shell=bash\ -i
	"
	" ChatGPT:
	"   `set shell=bash\ -i` sets the Vim shell to execute commands
	"   using bash externally in interactive mode. The -i option
	"   makes Bash start in interactive mode. This is useful
	"   when running commands that require user input or produce
	"   output to an external terminal.
    "   By default, Vim uses /bin/sh as the shell, which is
    "   often a symlink to another shell like Bash or Dash.
    "   However, some advanced shell features or aliases
    "   may not be available in /bin/sh, so setting the shell
    "   to a specific shell like Bash ensures that Vim can
    "   execute all commands correctly.
    "
    " `--execute` is a 'Sakura Terminal'-related option which means 'Execute command'.
    " `sakura --help` will show you `-x, --execute               Execute command`.
    "
	command! ChatGPT :silent! :!/usr/bin/sakura --execute chatgpt &
	:amenu AI.Open\ ChatGPT\ Console\ \(\:\ChatGPT\) :silent! :call ChatGPTLinux() <Esc>
  endif
endif
" -----------------------------------------

" -----------------------------------------
" OpenAI Console
if has("gui_running")
  " Opens OpenAI via console
  if g:osdetected == "Windows"
    :amenu AI.Launch\ OpenAI\ Console :silent !start cmd /k py-chatgpt <Esc>

  elseif g:osdetected == "Linux"
        function! OpenAILinux()
	           set shell=bash\ -i
	           ":!py-chatgpt &
	           :silent! :!/usr/bin/sakura -e bash -ic "py-chatgpt" &
	        "
	        " ChatGPT:
	       	"   The -e flag tells Sakura to stay open after the command has been
	        "   completed. `sakura -e` tells Sakura to run a specified command
	        "   without closing the terminal emulator automatically.
	        "   You need to manually close the terminal emulator by typing
	        "   exit or pressing Ctrl-D in the terminal emulator window.
	        "   The -ic option tells bash to treat itself as if it was
	        "   a login shell, execute a specific command, and then exit.
	        "   In this case, the specific command is py-chatgpt, which
	        "   will be executed by Python.
	        "   The & at the end of the line runs the command in
	        "   the background.
	        "
	    endfunction
        set shell=bash\ -i
        
        :amenu AI.Launch\ OpenAI\ Console\ \(\:\OpenAI\) :silent! :call OpenAILinux() <Esc>
        command! OpenAI :silent! :!/usr/bin/sakura -e bash -ic "py-chatgpt" &

  endif
endif
" -----------------------------------------

" -----------------------------------------
" Vista Plugin (Tagbar alternative) config
" ----- https://github.com/liuchengxu/vista.vim.git
" ----- https://liuchengxu.github.io/posts/vista.vim/
"
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

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
