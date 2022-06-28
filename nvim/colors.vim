" Colorscheme
" colorscheme gruvbox
colorscheme horizon

let g:horizon_transparent_bg=1

" Use truecolor
set termguicolors

" Use colors that favor dark backgrounds
set background=dark

" Transparency
hi Normal ctermfg=255 ctermbg=NONE guifg=#ffffff guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Terminal ctermfg=255 ctermbg=NONE guifg=#ffffff guibg=NONE guisp=NONE cterm=NONE gui=NONE

" TODO: Help
hi Todo cterm=bold gui=bold ctermbg=None ctermfg=LightGreen guibg=None guifg=#9f3e85
