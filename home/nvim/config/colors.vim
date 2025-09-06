" ================
" GLOBAL SETTINGS
" ================
" Use truecolor
if has('termguicolors')
  set termguicolors
endif

" Use colors that favor dark backgrounds
set background=dark

" Transparency
hi Normal ctermfg=255 ctermbg=NONE guifg=#ffffff guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Terminal ctermfg=255 ctermbg=NONE guifg=#ffffff guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Todo ctermfg=LightGreen ctermbg=NONE guifg=#9f3e85 guibg=NONE cterm=bold gui=bold

" ================
" LSP FLOAT WINDOWS
" ================
hi LspFloatWinNormal guifg=#ffffff guibg=#ffffff guisp=NONE gui=NONE
hi LspFloatWinBorder guifg=#3b4252 guibg=#ffffff guisp=NONE gui=NONE
