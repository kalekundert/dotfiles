set wrap
set linebreak
set breakindent
set textwidth=0
set wrapmargin=0
set fo=roj
set comments=b:%,b:%¶,b:%§,
set spell

"Hard-wrap options
"set tabstop=2
"set softtabstop=2
"set shiftwidth=2
"set formatoptions+=a

noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$
noremap ^ g^
onoremap <silent> j gj
onoremap <silent> k gk

map K <Nop>

" Use the structure of the document to create folds.
set foldmethod=expr
set foldexpr=TexFoldExpressionCaller()
set foldtext=TexFoldTextCaller()

function! TexFoldExpression(lnum)
    let line = getline(a:lnum)

    " Make 1 big fold for the preamble.
    
    if line =~ '^\\documentclass\(\[.*\]\)\?{'
        return '>1'
    endif

    if line =~ '^\\begin{document}'
        return '>1'
    endif

    " Make a new fold for each section.

    if line =~ '^\\section\*\?{'
        return '>1'
    endif

    if line =~ '^\\subsection\*\?{'
        return '>2'
    endif

    if line =~ '^\\subsubsection\*\?{'
        return '>3'
    endif

    if line =~ '^\\organizedsection{'
        return '>1'
    endif

    if line =~ '^\\printbibliography'
        return '>1'
    endif

    " If none of the above criteria were met, keep the fold level the same as
    " it was on the previous line.  See `:help fold-expr' for the meaning of
    " the return strings.

    return '='

endfunction

function! TexFoldText(foldstart, foldend)

    " Find the line that should be used to summarize the fold.

    let line = getline(a:foldstart)

    " Count the number of lines and words in the fold.

    let i = a:foldstart + 1
    let line_count = a:foldend - a:foldstart
    let word_count = 0

    while (i + 1 <= a:foldend)
        if getline(i) !~ '^\s*%'
            let word_count += len(split(getline(i)))
        endif
        let i += 1
    endwhile

    " Format the status
    let status = '(' . word_count . ' words)'
    let cutoff = &columns - strlen(status)
    let title = line
    
    if strlen(title) >= cutoff
        let title = title[0:cutoff - 4] . '...'
        let padding = ''
    else
        let padding = cutoff - strlen(title) - 1
        let padding = ' ' . repeat(' ', padding)
    endif

    return title . padding . status

endfunction

function! TexFoldExpressionCaller()
    return TexFoldExpression(v:lnum)
endfunction

function! TexFoldTextCaller()
    return TexFoldText(v:foldstart, v:foldend)
endfunction

