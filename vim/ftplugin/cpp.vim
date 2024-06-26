" Use tabs instead of spaces and set the tabstop to 2.
set tabstop=2
set softtabstop=0
set shiftwidth=2
set noexpandtab

" Enable sophisticated text editing within comments.
set spell
set formatoptions+=a

" Use the structure of the code to create folds.
set foldmethod=expr
set foldexpr=CppFoldExpressionCaller()
set foldtext=CppFoldTextCaller()

function! CppFoldExpression(lnum)  " {{{1

    " The purpose of this function is to decide how the given line should be 
    " folded.  There are three possible outcomes: open a new fold, close the 
    " existing fold, or don't change anything.
    "
    " The code decides where to open new folds by looking for blocks of 
    " 'top-level' (i.e. unindented) text.  If the block contains a particular 
    " pattern --- e.g. '{' for function definitions --- the first line in that 
    " block set as the beginning of the fold.
    "
    " The code decides where close folds by looking for blank lines.  If the 
    " line above that blank line is part of a top-level block, the current fold 
    " is closed.  (This does lead to a few cases where we try to close a fold 
    " that doesn't exist, but fortunately vim handles this gracefully.)
    " 
    " If neither of the above to conditions are met, the fold level is simply 
    " maintained.

    let line = getline(a:lnum)
    let previous_line = getline(a:lnum - 1)
    let next_line = getline(a:lnum + 1)
    let next_next_line = getline(a:lnum + 2)

    let blank_pattern = '^\s*$'
    let top_level_pattern = '^\S'
    let open_fold_pattern = '{\|('
    let dont_fold_pattern = '^\(namespace\|static\|#\|)\|{\|}\|.*:$\)'
    let skip_line_pattern = '^\/\/'
    let close_fold_pattern = '^}'
    let close_header_pattern = '^namespace'

    " Attempt to make a fold for all the headers by always opening a fold on 
    " the first line, and closing a fold two lines before seeing 'namespace'.

    if a:lnum == 1
        return '>1'
    endif 

    if next_next_line =~ close_header_pattern
        return '<1'
    endif

    " When a blank line is found, decide if it should be used to close a fold 
    " by investigating the previous line.  If the previous line is part of a 
    " top-level block, close the fold.

    if line =~ blank_pattern
        if previous_line =~ close_fold_pattern
            return '<1'
        else
            return '='
        endif
    endif

    " The rest of this function determines where new folds should be opened.  
    " Since folds can only open on unindented lines, we can immediately ignore 
    " any line that doesn't begin with whitespace.

    if line !~ top_level_pattern
        return '='
    endif

    " Only the first line of a top-level block can open a fold, so don't change 
    " the fold level if there is another top-level line above this one.

    if previous_line =~ top_level_pattern
        return '='
    endif

    " There are a few kinds of lines that I don't want to start new blocks.  
    " These are namespaces, classes, and a few kinds of punctuation that would 
    " otherwise confuse the code.  If such a line if encountered, don't count 
    " it as being top-level.

    if line =~ dont_fold_pattern
        return '='
    endif

    " If the function has gotten this far, then we know this is the first line 
    " of a top-level block.  To decide if we want this block to be folded, we 
    " search through it until either we find a line matching a pre-specified 
    " fold pattern or the block ends (i.e. we encounter a blank line).  Some 
    " lines (i.e. comments) are not searched for the fold pattern.

    let next_line = line
    let offset = 0

    while next_line !~ blank_pattern
        if next_line !~ skip_line_pattern
            if next_line =~ open_fold_pattern
                return '>1'
            endif
        endif

        let offset += 1
        let next_line = getline(a:lnum + offset)
    endwhile

    " If none of the above criteria were met, keep the fold level the same as
    " it was on the previous line.  See `:help fold-expr' for the meaning of
    " the return strings.

    return '='

endfunction

function! CppFoldText(foldstart, foldend)    " {{{1

    " Search for a line that looks like a function in each fold.  If such a 
    " line is found, use it to display the fold.  Otherwise, use the first 
    " line.

    let line_counter = a:foldstart
    let lines_searched = 0

    while 1
        let line = getline(line_counter)
        let line_counter += 1
        let lines_searched += 1

        " Stop looking once a blank line is found.
        if line =~ '^\s*$'
            let line = getline(a:foldstart)
            break
        endif

        " Skip comments
        if line =~ '^\s*\/\/' || line =~ '@'
            continue
        endif

        " Skip blank start markers
        if line =~ '^\s*\/\/ {{[{]'
            continue
        endif

        " If a function name is found, use it to name the fold.
        if line =~ '('
            break
        endif

        " If a class definition is found, use it to name the fold.
        if line =~ '^\<\(class\|struct\)\>'
            break
        endif

        " Give up once the end of the fold is reached.
        if line_counter > a:foldend
            let line = getline(a:foldstart)
            break
        endif

    endwhile

    " Break the line into two parts: a title and a set of flags.  The title 
    " will be left-justified, while the flags will be concatenated together and 
    " right-justified.

    let title = line
    let flags = []

    " Format a succinct fold message.  The title is stripped of whitespace and 
    " truncated, if it is too long to fit on the screen.  The total number of 
    " folded lines are added as an extra tag, and all the flags are wrapped in 
    " parenthesis.

    let flags = add(flags, 1 + a:foldend - a:foldstart)
    let status = ' (' . join(flags, ') (') . ')'
    let cutoff = &columns - strlen(status)

    let title = substitute(title, '\t', '  ', 'g')
    let title = substitute(title, '^\(.\{-}\)\s*\(/*\s*{{{\d\)\=\s*$', '\1', '') " }}}
    
    " Remove the return value, if there is one, from the title to make all the 
    " method names line up.
    let words = split(title)
    if words[0] !~ '('
        let title = join(words[1:], ' ')
    endif
    
    if strlen(title) >= cutoff
        let title = title[0:cutoff - 4] . '...'
        let padding = ''
    else
        let padding = cutoff - strlen(title) - 1
        let padding = ' ' . repeat(' ', padding)
    endif

    return title . padding . status

endfunction

function! CppFoldExpressionCaller()  " {{{1
    return CppFoldExpression(v:lnum)
endfunction

function! CppFoldTextCaller()    " {{{1
    return CppFoldText(v:foldstart, v:foldend)
endfunction     " }}}1
