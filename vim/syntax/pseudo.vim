" Pseudocode Syntax File
" ======================
" This is a syntax file for an extremely readable pseudocode language I'm using 
" for a presentation.  

" Only perform spell-checking within syntax groups.
syntax spell notoplevel

" Match all of the builtin keywords.
syntax keyword pseudoKeyword repeat if not or once every for each until 
syntax region pseudoString start='"' end='"' oneline contains=@Spell
syntax match pseudoComment "//.*$" contains=@Spell

" Link the Matlab groups to standard syntax ones.
highlight def link pseudoKeyword Statement
highlight def link pseudoString String
highlight def link pseudoComment Comment

let b:current_syntax = "pseudo"
