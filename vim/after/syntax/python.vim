" Highlight some special values.
syntax keyword pythonConstant True False None

" Clear out the default string patterns.
syntax clear pythonString
syntax clear pythonComment

" Don't spell check special characters within strings.
syntax match pythonSpecialString "%[^'" ]" contained
syntax match pythonSpecialString "\\." contained

" Include the quotes in the region matched by pythonString.  Note the negative 
" lookahead (\@!), which is important to avoid matching what should be 
" triple-quoted strings.
syntax region pythonString start='[furb]*"\(""\)\@!' skip='\\"' end='"' oneline
            \ contains=pythonEscape,pythonSpecialString,@Spell

" Only do spell checking in double-quoted strings.
syntax region pythonString start="[furb]*'\(''\)\@!" skip="\\'" end="'" oneline
            \ contains=pythonEscape,pythonSpecialString,@NoSpell

" Match triple-quoted strings with backslashes after the third quote.  The 
" backslash is useful for getting rid of the first newline, and also making the 
" start/end tokens distinguishable.  Note that raw-strings cannot contain 
" line-continuing backslashes, so the 'r' prefix is not matched.
syntax region pythonString start='[fub]*"""\\' end='"""'
            \ contains=pythonEscape,pythonSpecialString,@Spell
syntax region pythonString start="[fub]*'''\\" end="'''"
            \ contains=pythonEscape,pythonSpecialString,@NoSpell

" Add a special rule for any string with a leading character, because this also 
" makes the start/end tokens distinguishable.
syntax region pythonString start='[furb]\+"""' end='"""'
      \ contains=pythonEscape,pythonSpecialString,@Spell
syntax region pythonString start="[furb]\+'''" end="'''"
      \ contains=pythonEscape,pythonSpecialString,@NoSpell

" Recognize some restructured text inside comments.
syntax region pythonVerbatim start="``" end="``" oneline
            \ transparent keepend contained contains=@NoSpell
syntax region pythonVerbatim start="`" end="`" oneline
            \ transparent keepend contained contains=@NoSpell
syntax region pythonVerbatim start="<" end=">" oneline
            \ transparent keepend contained contains=@NoSpell

" Match docstrings as comments, rather than strings.
syntax match pythonFoldHint "[:[{(] \zs#$"
syntax match pythonFoldHint "^@.*\zs#$"
syntax match pythonComment "#.*$"
            \ contains=pythonVerbatim,pythonAcronym,@Spell
syntax region pythonComment start='^ *r\="""$' end='"""$'
            \ keepend contains=pythonVerbatim,pythonAcronym,@Spell
syntax region pythonComment start="^ *r\='''$" end="'''$"
            \ keepend contains=pythonVerbatim,pythonAcronym,@NoSpell

" Recognize the magic comments that I tend to put in files.
syntax match pythonMagicComment "^#!.*python.*$" contains=@NoSpell
syntax match pythonMagicComment "^# encoding: latin-1$" contains=@NoSpell
syntax match pythonMagicComment "^# encoding: utf-8$" contains=@NoSpell
syntax match pythonMagicComment "^# vim: .*$" contains=@NoSpell
syntax match pythonMagicComment "^# pylint: .*$"
syntax match pythonMagicComment "# pragma: no cover"

" Highlight the whole line for decorators.
syntax clear pythonDecorator
syntax match pythonDecorator "^\s*@.*$" contains=pythonComment,pythonFoldHint

" Don't highlight the exception base class.
syntax keyword pythonExceptionBaseClass Exception

" Unless this is explicitly labeled as a python2 script, don't highlight print 
" or exec, as they are no longer keywords.
if getline(1) !~ "python2"
    syntax keyword pythonPrint print
    highlight link pythonPrint Normal

    syntax keyword pythonExec exec
    highlight link pythonExec Normal
endif

" Change how some groups are colored
highlight link pythonInclude Statement
highlight link pythonPreCondit Statement
highlight link pythonMagicComment SpecialComment

highlight link pythonConstant Constant 
highlight link pythonExceptions Normal
highlight link pythonDecorator PreProc
highlight link pythonPrintFunction Normal

highlight link pythonEscape String
highlight link pythonSpecialString String
highlight link pythonExceptionBaseClass Normal

let s:lightgrey = "#eee8d5" 
let s:darkgrey = "#073642"
highlight pythonFoldHint guifg=lightgrey ctermfg=darkgrey

