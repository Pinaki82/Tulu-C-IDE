"" Creating directories if they don't exist
" Comment the following lines after creating these directories
silent execute '!mkdir "'.$HOME.'/.vimbackup"'
silent execute '!mkdir "'.$HOME.'/.vimswap"'
silent execute '!mkdir "'.$HOME.'/.vimviews"'
silent execute '!mkdir "'.$HOME.'/.vimundo"'
let g:clang_c_completeopt = 'longest,menuone,preview'
