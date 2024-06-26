" Matlab/Octave Syntax File
" =========================
" This is a pared-down version of the standard Matlab syntax file.  Only
" keywords, strings, and comments are highlighted.

" Only perform spell-checking within syntax groups.
syntax spell notoplevel

" Match all of the builtin keywords.
syntax keyword matlabKeyword break case catch continue do else elseif end for
syntax keyword matlabKeyword function global if otherwise persistent return
syntax keyword matlabKeyword static switch try while until
 
" Double-quoted strings work in octave, but are incompatible with matlab.  And
" unlike most languages, the quote character itself is escaped by placing two
" of them back to back.
syntax region matlabString start="'" end="'" skip="''" oneline contains=@Spell

" Single line comments are initiated with a single '%' character.  Multi-line
" comments begin wiht '%{' and end with '%}'.
syntax match matlabComment "%.*$" contains=@Spell
syntax region matlabComment start='%{' end='%}' keepend contains=@Spell

syntax match matlabImportant "%!.*$" contains=@Spell
syntax match matlabShebang "^#!/usr/bin/octave -q$"

" Match the line continuation pattern, which is an ellipsis.
syntax match matlabLineContinuation "\.\{3}"

" Link the Matlab groups to standard syntax ones.
highlight def link matlabKeyword Statement
highlight def link matlabLineContinuation Statement

highlight def link matlabString String
highlight def link matlabComment Comment

highlight def link matlabImportant SpecialComment
highlight def link matlabShebang SpecialComment

let b:current_syntax = "matlab"
