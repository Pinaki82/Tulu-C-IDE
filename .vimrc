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

" ============================================
source $HOME\/\.vimdotcommon\/\.vimrc2.vim
" ============================================

" ============================================
" how to start vim with a specific width and height
" https://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim


if !has("gui_running")
  " When the GUI is not running and Vim is started from the terminal.
  if exists("+lines")
    set lines=34
  endif
  if exists("+columns")
    set columns=115
  endif
endif
" ============================================

" ============================================
""     setting up a dark colorscheme at startup (Terminal)
" if !has("gui_running")
"     colo mustang_green
" endif
" ============================================
