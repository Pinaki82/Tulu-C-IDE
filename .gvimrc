" how to start vim with a specific width and height
" https://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=29 columns=100
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

