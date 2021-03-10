" how to start vim with a specific width and height
" https://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=34 columns=115
endif

""     setting up a dark colorscheme at startup (GUI. GVim)
" if has("gui_running")
"     colo mustang_green
" endif
