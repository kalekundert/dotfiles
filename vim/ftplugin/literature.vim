" Enable spell checking.
set spell

" Turn on automatic formatting.
set formatoptions+=a

" Define abbreviations for two key strings.
abbreviate === ===============================================================================
abbreviate --- -------------------------------------------------------------------------------

" Use the structure of the file to create folds.
set foldmethod=expr
set foldexpr=LiteratureFoldExpressionCaller()
set foldtext=LiteratureFoldTextCaller()

function! LiteratureFoldExpression(lnum)    " {{{1

    let line = getline(a:lnum)
    let next_line = getline(a:lnum + 1)

    let title_pattern = '^==='
    let section_pattern = '^\a*:$'
    let blank_pattern = '^\s*$'

    " Create level-1 folds for each entry and level-2 folds for each section 
    " within an entry.

    if line =~ title_pattern
        return '>1'
    endif

    if line =~ section_pattern
        return '>2'
    endif

    " Decrease the fold level by one for each pair of consecutive blank lines 
    " that are encountered.  This makes it possible to organize the folds.

    if (line =~ blank_pattern) && (next_line =~ blank_pattern)
        return 's1'
    endif

    " Don't change the fold level if none of the above criteria were met.

    return '='

endfunction

function! LiteratureFoldText(foldstart, foldend)    " {{{1

    let line = getline(a:foldstart)
    let title_line = getline(a:foldstart + 1)
    let author_line = getline(a:foldstart + 2)

    let title_pattern = '^==='
    let author_pattern = '^---'
    let section_pattern = '^\a*:$'

    " Determine what text should be displayed based on the type of fold 
    " starting on this line.  If it is the beginning of an entry, find the 
    " title of the entry are truncate it if necessary.  If it is a section, 
    " simply use the section name.

    if line =~ title_pattern
        if author_line =~ author_pattern
            let text = title_line
        else
            let text = title_line[0:-2] . '...'
        endif
    endif

    if line =~ section_pattern
        let text = line
    endif

    " Format the fold message by adding the number of folded lines onto the far 
    " right side.  The middle is padded with whitespace.

    let lines = ' (' . (1 + a:foldend - a:foldstart) . ')'
    let cutoff = &columns - strlen(lines)

    echo lines
    
    if strlen(text) >= cutoff
        let text = text[0:cutoff - 4] . '...'
        let padding = ''
    else
        let padding = cutoff - strlen(text) - 1
        let padding = ' ' . repeat(' ', padding)
    endif

    return text . padding . lines

endfunction

function! LiteratureFoldExpressionCaller()  " {{{1
    return LiteratureFoldExpression(v:lnum)
endfunction

function! LiteratureFoldTextCaller()    " {{{1
    return LiteratureFoldText(v:foldstart, v:foldend)
endfunction     " }}}1


