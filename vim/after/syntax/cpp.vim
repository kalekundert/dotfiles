" Don't highlight variable names, even 'this'.
syn keyword cppThis	this
highlight link cppThis Normal

" Allow braces within brackets (they can be initializer lists).
syn clear cErrInBracket 
syn match cErrInBracket display contained "[);]\|<%\|%>"

" Highlight 'string' as if it were a built-in type.
syn match notType "std::string"
syn keyword cType string

" Highlight for-each constructs like any other control flow keyword.
syn keyword cppForEach foreach BOOST_FOREACH
highlight link cppForEach cRepeat

" Highlight % as it's used for boost::format.
syn match cFormat display "%\d\+%" contained

" Don't spell-check email addresses in comments.
syn match cppEmailAddress "([a-zA-Z0-9.]\+.[a-zA-Z0-9.]\+)" 
            \ contains=@NoSpell contained transparent
syn cluster cCommentGroup add=cppEmailAddress

" Don't spell-check function names in comments.
syn match cppFunctionComment "[a-zA-Z0-9_]\+()" 
            \ contains=@NoSpell contained transparent
syn cluster cCommentGroup add=cppFunctionComment

" Don't spell-check the name of the file being edited in strings or comments.
let filename = split(expand('%:t'), '\.')[0]
execute "syn keyword cSpecial " . filename . " contained transparent"
execute "syn keyword cppFileName " . filename . " contained transparent"
syn cluster cCommentGroup add=cppFileName

" Don't spell-check verbatim regions in comments.
syn region cppVerbatim start="`" end="'" contained transparent contains=@NoSpell
syn cluster cCommentGroup add=cppVerbatim
