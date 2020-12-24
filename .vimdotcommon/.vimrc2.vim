" Last Change: 2020-12-21  Monday: 06:33:23 AM
" ============================================
" Write the following line to your _vimrc or .vimrc and uncomment the line
" source $HOME\/\.vimrc2.vim


" ============================================
"  ******************************************
" ============================================
" http://vi.stackexchange.com/questions/2572/detect-os-in-vimscript
" google: detecting os from vimscript
if !exists("g:osdetected")
    if has("win64") || has("win32") || has("win16")
        let g:osdetected = "Windows"
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
set number        " always show line numbers
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

" CTRL-F4 is close
vnoremap <C-F4> :close <Enter>
if g:osdetected != "Windows"
  vnoremap <C-F4> :close <Enter>
  nnoremap <C-F4> :close <Enter>
endif

" CTRL-D is Buffer Delete
map <C-D> <Esc>:confirm bd <CR><Esc>

" make text uppercase F5 and lowercase SHIFT-F5 respectively
:map! <F5> <Esc>gUiw`]a
:map! <S-F5> <Esc>guiw`]a

" nmap <F11> :TagbarToggle<CR>
" map <S-F11> :Tlist <Enter>

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

:amenu Settings.-Sep0-	:
:amenu Settings.Restore\ Coloured\ Status\ Line :call ColStline() <CR>


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
:menu Settings.-Sep1-	:

"                                    Setting for some Modified Default colour schemes, you will find more later
:amenu Settings.Modified\ Default\ Themes.default\ <Alt-F11> :call <SID>ThemeDefault() <CR>
map <M-F11> :call <SID>ThemeDefault() <CR>
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
colors default
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

" Opens Useful Apps and Programs
if g:osdetected == "Windows"
        :amenu Utilities.notepad :silent!!start "notepad.exe" <CR><Esc><CR>
        :amenu Utilities.Open\ with\ notepad :silent !start "notepad.exe" "%:p" <CR><Esc><CR>
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

        :amenu Utilities.xedit :call Xedit_open() <CR><Esc><CR>
        :amenu Utilities.Open\ with\ xedit :call Open_w_Xedit() <CR><Esc><CR>
        :amenu Utilities.Open\ meld\ (\file\ compare\ utility\) :call Meld_diff_viewer() <CR><Esc><CR>

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
        fun! Meld_diff_viewer()
          :silent!!meld &
        endfun

endif

endif
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

"  ======================================================
" ~~~~~~~~~~~ YankRing plugin Configuration ~~~~~~
:nnoremap <silent> <C-F11> :YRShow<CR>
 function! YRRunAfterMaps()
   nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
 endfunction
" ~~~~~~~~~~~ YankRing plugin Configuration ends ~~~~~~

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
    source $HOME\/\.vimdotwin\/\.set_tags_n_set_paths.txt
  else
    source $HOME\/\.vimdotlinux\/\.set_tags_n_set_paths.txt
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

Plug 'https://github.com/preservim/nerdtree.git'

Plug 'https://github.com/justmao945/vim-clang.git'

Plug 'https://github.com/vim-syntastic/syntastic.git'

Plug 'https://github.com/vim-scripts/matchparenpp.git'

Plug 'https://github.com/matze/vim-move.git'

Plug 'https://github.com/preservim/nerdcommenter.git'

Plug 'https://github.com/suxpert/vimcaps.git'

Plug 'https://github.com/vim-scripts/AutoClose.git'

Plug 'https://github.com/vim-scripts/auto-tags-gen.git'

Plug 'https://github.com/WolfgangMehner/vim-plugins.git'

Plug 'https://github.com/WolfgangMehner/git-support.git'

Plug 'https://github.com/weynhamz/vim-plugin-minibufexpl.git'

Plug 'https://github.com/xuhdev/SingleCompile.git'

Plug 'https://github.com/artnez/vim-wipeout.git'

Plug 'https://github.com/Pinaki82/code_complete.git'

Plug 'https://github.com/Pinaki82/artistic_styler_console_direct.vim.git'

Plug 'https://github.com/Pinaki82/VimLongLineMarker.git'

Plug 'https://github.com/Pinaki82/Omni-Completion-at-CTRL-SPACE.git'

Plug 'https://github.com/Pinaki82/vim-move-Keyboard-Shortcut.git'

Plug 'https://github.com/Pinaki82/Vim-Syntastic-Setup.git'

Plug 'https://github.com/Pinaki82/TimeStamp2.git'

Plug 'https://github.com/Pinaki82/vim-clang-Settings.git'

Plug 'https://github.com/vim-scripts/stlrefvim.git'

Plug 'https://github.com/Pinaki82/crefvim2.git'

Plug 'https://github.com/vim-scripts/YankRing.vim.git'

Plug 'https://github.com/Pinaki82/Reload-Button.git'

Plug 'https://github.com/croaker/mustang-vim.git'

Plug 'https://github.com/Pinaki82/mustang_green-Vim-Colourscheme.git'

Plug 'https://github.com/Pinaki82/oh-la-la.git'

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

" auto_tags_gen plugin startup with option 1
let g:startuptrigger = 1

