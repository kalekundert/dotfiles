" Lines that begin with special punctuation characters are taken to be code or
" shell demonstrations.  These lines will not be spell-checked.
syntax match textDemonstration '^\s\+[~#$>|] .*$' contains=@NoSpell
syntax match textDemonstration '^\s\+[/~:].*$' contains=@NoSpell

" Highlight the vim modeline syntax.
syntax match textModeline "^vim: .*"  contains=@NoSpell

" Strings within single-quotes should not be spell-checked.
syntax region textVerbatim start="`" end="'" oneline contains=@NoSpell

" URLs (denoted by angle-brackets) should also not be spell checked.
syntax region textURL start="<" end=">" oneline contains=@NoSpell

" Try to avoid spell-checking acronyms.
syntax match textAcronym "\<[A-Z0-9]\{2,}\>" contains=@NoSpell

" Try to avoid spell-checking file paths.
syntax match textFilePath "\S*\.\(txt\|py\|sh\)" contains=@NoSpell

" Recognize a few non-english phrases.
syntax keyword textLatin apo holo

highlight textDemonstration gui=italic cterm=bold term=bold
highlight textModeline guifg=LightGrey ctermfg=DarkGrey
highlight textLatin gui=italic cterm=bold term=bold
