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
" :set timeout timeoutlen=4500 "   ttimeoutlen=100 "  default settings -1 not harmed under comment
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
autocmd BufWritePre * :call <SID>StripWhite()
fun! <SID>StripWhite()
    %s/[ \t]\+$//ge
    %s!^\( \+\)\t!\=StrRepeat("\t", 1 + strlen(submatch(1)) / 8)!ge
endfun
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
:amenu Settings.Coloured\ Status\ Line :call ColStline() <CR>


:amenu Settings.Highlight\ Line\ and\ column\ ON-OFF\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \\hl   :call ToggleHighlightLineColumn()<cr>


nnoremap <Leader>hl :call ToggleHighlightLineColumn()<cr>
vnoremap <Leader>hl :call ToggleHighlightLineColumn()<cr>
inoremap <Leader>hl <Esc><Esc>:call ToggleHighlightLineColumn()<cr>

endif

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
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Trim Trailling Whitespace
:amenu Utilities.Trim\ Trailling\ Whitespace :call <SID>StripWhite() <CR>
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

Plug 'https://github.com/junegunn/vim-plug'

Plug 'https://github.com/preservim/nerdtree'

Plug 'https://github.com/justmao945/vim-clang'

Plug 'https://github.com/vim-syntastic/syntastic'

Plug 'https://github.com/vim-scripts/matchparenpp'

Plug 'https://github.com/matze/vim-move'

Plug 'https://github.com/preservim/nerdcommenter'

Plug 'https://github.com/suxpert/vimcaps'

Plug 'https://github.com/vim-scripts/AutoClose'

Plug 'https://github.com/vim-scripts/auto-tags-gen'

Plug 'https://github.com/WolfgangMehner/vim-plugins'

Plug 'https://github.com/WolfgangMehner/git-support.git'

Plug 'https://github.com/weynhamz/vim-plugin-minibufexpl'

Plug 'https://github.com/matze/vim-move'

Plug 'https://github.com/xuhdev/SingleCompile'

Plug 'https://github.com/artnez/vim-wipeout'

Plug 'https://github.com/Pinaki82/code_complete'

Plug 'https://github.com/Pinaki82/artistic_styler_console_direct.vim'

Plug 'https://github.com/Pinaki82/VimLongLineMarker'

Plug 'https://github.com/Pinaki82/Omni-Completion-at-CTRL-SPACE'

Plug 'https://github.com/Pinaki82/vim-move-Keyboard-Shortcut'

Plug 'https://github.com/Pinaki82/Vim-Syntastic-Setup'

Plug 'https://github.com/Pinaki82/TimeStamp2'

Plug 'https://github.com/Pinaki82/vim-clang-Settings'

Plug 'https://github.com/vim-scripts/stlrefvim'

Plug 'https://github.com/Pinaki82/crefvim2'


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

