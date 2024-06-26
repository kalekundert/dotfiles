" Simple Color Scheme
" ===================
" This is a color scheme that only uses two colors: black and white.  To
" distinguish between different syntax items, bold and italic fonts are used.
" Unfortunately, this scheme only works in the built-in graphical interface.
"
" -Kale Kundert

" Bureaucratic stuff
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name="hardcopy"

" Pick the text color based on the background.
if &background == "dark"
    highlight Normal        guifg=White guibg=Black
else 
    highlight Normal        guifg=Black guibg=White
endif

" Color the basic syntax groups accordingly.
highlight Error             guifg=fg gui=none

highlight Comment           guifg=fg gui=bold 
highlight Todo              guifg=fg gui=none

highlight Constant          guifg=fg gui=italic 
highlight String            guifg=fg gui=none
highlight Number            guifg=fg gui=none

highlight Statement         guifg=fg gui=italic 
highlight Identifier        guifg=fg gui=none
highlight Function          guifg=fg gui=none
highlight Type              guifg=fg gui=italic 

highlight PreProc           guifg=fg gui=none

highlight Special           guifg=fg gui=bold 
highlight SpecialComment    guifg=fg gui=italic

highlight SpellBad          guifg=fg gui=underline 
highlight SpellCap          guifg=fg gui=underline 
highlight SpellRare         guifg=fg gui=underline 
highlight SpellLocal        guifg=fg gui=underline 

highlight DiffAdd           guifg=bg guibg=fg
highlight DiffChange        guifg=bg guibg=fg
highlight DiffDelete        guifg=bg guibg=fg
highlight DiffText          guifg=bg guibg=fg

highlight Cursor            guifg=bg guibg=fg
highlight LineNr            guifg=fg
highlight NonText           guifg=fg gui=bold

highlight Visual            guifg=bg guibg=fg
highlight Folded            guifg=bg guibg=fg
highlight MatchParen        guifg=bg guibg=fg

" Link the less common groups to the basic ones.
runtime 'shared.vim'

