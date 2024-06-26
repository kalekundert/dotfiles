" This file is in after/ so that it overrides anything done by my plugins.

" Configure commentary.  This is mostly copied from an old version of 
" commentary.  I don't know why they got rid of these mapping; they seem better 
" to me.

" If B is missing from cpoptions, Vim will treat backslashes in the
" following mappings as escape sequences, when we actually want these to
" be literal backslashes. So temporarily set B in cpoptions.
let save_cpo = &cpoptions
set cpoptions+=B

xmap \\  <Plug>Commentary
nmap \\  <Plug>Commentary
nmap \\\ <Plug>CommentaryLine
nmap \\~ <Plug>Commentary<Plug>Commentary
nmap \\c <Plug>ChangeCommentary

let &cpoptions = save_cpo


" Nice hotkeys that mimic my shell aliases for vim-fugitive
nnoremap gs :Gstatus
nnoremap gd :Gdiff
nnoremap gc :Gcommit

map <C-E> :NERDTreeToggle<CR>
nmap <C-s> :FSHere<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow searching within a visual block.
vnoremap g/ <esc>/\%V
vnoremap g? <esc>?\%V

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Provide an easy way to jump back to the end of words.  Keep the macro 
" function available by moving it to `.
noremap q ge
noremap Q gE
noremap ` q

" Make 'Y' behave like 'D'.  
noremap Y y$

" Automatically center the screen hen jumping to a mark.
noremap '' ''zz

" Fix misspelled words easily.
noremap == 1z=

" Easier hotkey for reformatting text.
"noremap K gq

" Insert the current date with one hotkey.  Note: I wanted to map this to 
" <C-;>, because that's the hotkey for the same function in spreadsheet 
" programs, but ; cannot be mapped in vim for arcane reasons.
nmap <C-y> i<C-R>=strftime("%Y/%m/%d")<CR>
imap <C-y> <C-R>=strftime("%Y/%m/%d")<CR>

" Unicode character entry.  I'm disabling these for now, because I'm trying to 
" get more used to the system-wide mappings (even though they're not quite as 
" convenient.)
inoremap <C-d> <C-k>
digraph el 8467 " Script small L
digraph -- 8722 " Minus sign
digraph c$ 162  " Cent sign
digraph '' 8217 " Right single quotation mark

" I have no idea what this does; I don't think I ever use it.
map <leader>K v}k:s/ *$/ /<CR>$x<C-O>gq}

" Hotkeys for specifically searching for full words.
nmap g/ /\<\><Left><Left>
nmap g? ?\<\><Left><Left>

" Not sure what this does...
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute 'normal! vgvy'

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, '\n$', '', '')

    if a:direction == 'b'
        execute 'normal ?' . l:pattern . '^M'
    elseif a:direction == 'f'
        execute 'normal /' . l:pattern . '^M'
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Toggle showing undesired whitespace characters.
" <C-Space> seems to work in the GUI, while <C-@> seems to work in the 
" terminal.
nnoremap <C-Space> :set list!<CR>
nnoremap <C-@> :set list!<CR>
inoremap <C-Space> <C-O>:set list!<CR>
inoremap <C-@> <C-O>:set list!<CR>

" Consistent hotkeys for panning the window.
noremap <C-j> <C-e>
noremap <C-k> <C-y>
noremap <C-h> zh
noremap <C-l> zl
inoremap <C-j> <C-o><C-e>
inoremap <C-k> <C-o><C-y>
inoremap <C-h> <C-o>zh
inoremap <C-l> <C-o>zl

" Hotkeys for toggling between windows.
map <C-w><C-w> :wincmd p<CR><CR><CR>
map <C-w>w :wincmd p<CR>
map <C-w><C-p> :wincmd w<CR>
map <C-w>p :wincmd w<CR>

" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"


