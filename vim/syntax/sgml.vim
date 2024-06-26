" HTML Syntax File
" ================
" This is a simple script meant to replace the default HTML syntax file.  Much
" more than than the default file, this script emphasizes using only a small
" number of meaningful syntax groups.  Having fewer groups makes the
" highlighting scheme easier to understand and manipulate, albeit at the cost
" of some functionality.

syntax case ignore

" Spell-check everywhere that does not match a syntax group.
syntax spell toplevel

" The element group matches anything between angle brackets and provides a
" context for other syntax groups, while the dummy group is only there to
" contain a @Spell cluster (strangely necessary for spell-checking).  It is
" completely masked by the higher-priority element group.
syntax region htmlDummyRegion start='<' end='>' contains=@Spell
syntax region htmlElement start='<' skip='="[^"]*>[^"]*"' end='>' keepend contains=htmlBracket,htmlAttr,htmlValue

" It looks like these patterns just match brackets, but there is actually
" some subtlety here.  Since a few tags share names with attributes, the
" nextgroup argument is needed to give those tag names priority after a
" bracket.  Normally, the attribute names have priority since they are
" defined later.  
syntax match htmlBracket contained '</\=[a-z]'me=e-1 nextgroup=htmlTag
syntax match htmlBracket contained '/\=>'

" These keywords just match all the tag names defined by W3C.
syntax keyword htmlTag contained a abbr acronym address area b base bdo big blockquote body br button caption cite
syntax keyword htmlTag contained code col colgroup dd del dfn div dl dt em fieldset form frame frameset h1 h2 h3 h4
syntax keyword htmlTag contained h5 h6 head hr html i iframe img input ins kbd label legend li link map meta noframes
syntax keyword htmlTag contained noscript object ol optgroup option p param pre q samp script select small span
syntax keyword htmlTag contained strong style sub sup table tbody td textarea tfoot th thead title tr tt ul var

" Likewise, these keywords match all the attribute names defined by W3C.
syntax keyword htmlAttr contained abbr accept-charset accept accesskey action align alink alt archive axis background
syntax keyword htmlAttr contained bgcolor border cellpadding cellspacing char charoff charset checked cite class
syntax keyword htmlAttr contained classid clear code codebase codetype color cols colspan compact content coords data
syntax keyword htmlAttr contained datetime declare defer dir disabled enctype face for frame frameborder headers
syntax keyword htmlAttr contained height href hreflang hspace http-equiv id ismap label lang language link longdesc
syntax keyword htmlAttr contained marginheight marginwidth maxlength media method multiple name nohref noresize
syntax keyword htmlAttr contained noshade nowrap object profile prompt readonly rel rev rows rowspan rules scheme
syntax keyword htmlAttr contained scope scrolling selected shape size span src standby start style summary tabindex
syntax keyword htmlAttr contained target text title type usemap valign value valuetype version vlink vspace width 

syntax keyword htmlAttr contained onblur onchange onclick ondblclick onfocus onkeydown onkeypress onkeyup onload
syntax keyword htmlAttr contained onload onmousedown onmousemove onmouseout onmouseover onmouseup onreset onselect
syntax keyword htmlAttr contained onsubmit onunload

" Matches an attribute value string, which can be either single or double
" quoted.
syntax region htmlValue contained matchgroup=htmlQuote start='"' end='"'
syntax region htmlValue contained matchgroup=htmlQuote start="'" end="'"

" Increasingly specific types of comments.  The order is important for
" priority purposes.
syntax region htmlComment start="<!--" end="-->" contains=@Spell
syntax region htmlDTD start="<!DOCTYPE" end=">"
syntax region htmlSSI start="<!--#" end="-->"

" Linking the HTML groups to standard syntax groups.
highlight def link htmlTag Statement
highlight def link htmlBracket Statement

highlight def link htmlAttr Type
highlight def link htmlValue String
highlight def link htmlQuote String

highlight def link htmlComment Comment
highlight def link htmlDTD PreProc
highlight def link htmlSSI PreProc

let b:current_syntax = "html"
