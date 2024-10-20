" how to start vim with a specific width and height
" https://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=52 columns=151 " For 1366x768 display resolution
  " set lines=43 columns=178 " For 1920x1080 display resolution
endif

""     setting up a dark colorscheme at startup (GUI. GVim)
if has("gui_running")
    colo nord
    :call ColStline()
endif

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
