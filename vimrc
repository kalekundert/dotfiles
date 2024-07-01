if exists("g:neovide")
  let g:neovide_scroll_animation_length = 0
  let g:neovide_cursor_animation_length = 0
  let g:neovide_cursor_trail_length = 0
  set guifont=Cousine:h10
  set background=light
endif


" Plugins {{{1
" =======
call plug#begin()

" Personal
Plug '~/hacking/projects/vim-coiled-snake'
Plug '~/hacking/projects/vim-python-tweaks'
Plug '~/hacking/projects/vim-nestedtext'
Plug '~/hacking/projects/vim-cpp-fold'
Plug '~/hacking/projects/vim-rst-fold'
Plug '~/hacking/projects/vim-toml-fold'
Plug '~/hacking/projects/vim-prima-facie'
Plug '~/hacking/projects/vim-colo-hardcopy'
Plug '~/hacking/projects/vim-solarized8-kbk'

" Essential
Plug 'vim-scripts/FSwitch'
Plug 'vim-scripts/cmdalias.vim'
Plug 'Konfekt/FastFold'
Plug 'aperezdc/vim-template'
Plug 'jamessan/vim-gnupg'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-commentary'

" Seem nice, but still getting used to.
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tommcdo/vim-lion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/VisIncr'
Plug 'ReekenX/vim-rename2'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'chrisbra/matchit'
Plug 'gioele/vim-autoswap'

"" Language-specific plugins
" 2024/05/14: I commented out everything having to do with vim-lsp, because it 
" was causing a weird warning I couldn't understand or fix.
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"Plug 'jeetsukumaran/vim-pythonsense'
Plug 'hail2u/vim-css3-syntax'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'lepture/vim-jinja'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'arakashic/chromatica.nvim'
Plug 'lervag/vimtex'
Plug 'lifepillar/vim-colortemplate'
Plug 'LukeGoodsell/nextflow-vim'
Plug 'psf/black', {'branch': 'stable'}

call plug#end()

" rust {{{2
let g:rust_fold = 2

" vim-lsp {{{2

" 2021/09/13: It seems that on_lsp_buffer_enabled is not being called anymore, 
" because I had to disable diagnostics from outside that function.  I couldn't 
" figure out why, though.
let g:lsp_diagnostics_enabled = 0

" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete

"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)

"     let g:lsp_format_sync_timeout = 1000
"     let g:lsp_diagnostics_enabled = 0
"     let g:lsp_diagnostics_signs_enabled = 0
"     let g:lsp_document_code_action_signs_enabled = 0
"     autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
" endfunction

" augroup vimrc_lsp
"     autocmd!
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END


" Use popups instead of preview windows.
" Commented this out because it doesn't work with nvim...
"set previewpopup=height:10,width:60
set completeopt-=preview

" vim-lsc {{{2
"let g:lsc_server_commands = {'python': 'pyls'}
"let g:lsc_auto_map = v:true

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" nestedtext {{{2

let g:nestedtext_folding = 1

" FastFold {{{2
let g:fastfold_minlines = 0

function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'biblatex' : 'pandoc'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

map zx <Esc>:set fdm=expr<CR>:syn enable<CR>
noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

" solarized_kbk {{{2
colorscheme solarized8_kbk

" css {{{2

augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" coiled-snake {{{2

function! g:CoiledSnakeConfigureFold(fold)
    if a:fold.type == 'struct'
        let a:fold.max_indent = -1
        let a:fold.max_level = -1

        if a:fold.indent == 0
            let a:fold.min_lines = 2
        elseif a:fold.opening_line.text =~# '\(byoc\|appcli\).*param\|__config__\|group_by\|merge_by\|assert'
            let a:fold.min_lines = 2
        endif
    endif
endfunction

" FSwitch {{{2
" These rules used to be set automatically by the plugin, but were removed from 
" more recent versions of the plugin for some reason.
augroup fswitch_au_group_kbk
    au!
    au BufEnter *.c    let b:fswitchdst = 'h'       | let b:fswitchlocs = 'reg:/src/include/ reg:|src|include/**| ifrel:|/src/|../include|'
    au BufEnter *.cc   let b:fswitchdst = 'hh'      | let b:fswitchlocs = 'reg:/src/include/ reg:|src|include/**| ifrel:|/src/|../include|'
    au BufEnter *.cpp  let b:fswitchdst = 'hpp h'   | let b:fswitchlocs = 'reg:/src/include/ reg:|src|include/**| ifrel:|/src/|../include|'
    au BufEnter *.cxx  let b:fswitchdst = 'hxx'     | let b:fswitchlocs = 'reg:/src/include/ reg:|src|include/**| ifrel:|/src/|../include|'
    au BufEnter *.C    let b:fswitchdst = 'H'       | let b:fswitchlocs = 'reg:/src/include/ reg:|src|include/**| ifrel:|/src/|../include|'
    au BufEnter *.m    let b:fswitchdst = 'h'       | let b:fswitchlocs = 'reg:/src/include/ reg:|src|include/**| ifrel:|/src/|../include|'
    au BufEnter *.h    let b:fswitchdst = 'c cpp m' | let b:fswitchlocs = 'reg:/include/src/ reg:/include.*/src/ ifrel:|/include/|../src|'
    au BufEnter *.hh   let b:fswitchdst = 'cc'      | let b:fswitchlocs = 'reg:/include/src/ reg:/include.*/src/ ifrel:|/include/|../src|'
    au BufEnter *.hpp  let b:fswitchdst = 'cpp'     | let b:fswitchlocs = 'reg:/include/src/ reg:/include.*/src/ ifrel:|/include/|../src|'
    au BufEnter *.hxx  let b:fswitchdst = 'cxx'     | let b:fswitchlocs = 'reg:/include/src/ reg:/include.*/src/ ifrel:|/include/|../src|'
    au BufEnter *.H    let b:fswitchdst = 'C'       | let b:fswitchlocs = 'reg:/include/src/ reg:/include.*/src/ ifrel:|/include/|../src|'
augroup END

" autoswap {{{2
set title titlestring=

" misc {{{2
"map <Tab> :NERDTreeToggle<CR>

autocmd FileType colortemplate set mouse+=a

let g:sh_fold_enabled = 3
autocmd FileType sh set foldmethod=syntax

let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"

" Use a backtick to put a selection inside an ReST inline pre-formatted tag.
let g:surround_96 = "`\r`"
let g:neosolarized_contrast = "high"
let g:javascript_plugin_jsdoc = 1
let g:startify_custom_header= []
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_always_populate_location_list = 1
let r_syntax_folding = 1
let java_allow_cpp_keywords = 1
let python_highlight_exceptions = 1
let python_highlight_space_errors = 1
let python_no_builtin_highlight = 1
let fortran_dialect = 'f90'
let vim_markdown_preview_github=1
let g:templates_directory = split(&runtimepath, ',')[0] . '/templates'
let g:templates_global_name_prefix = 'template'

" }}}2

" General Options {{{1
" ===============
set nobackup
set wildignore=*.swp,*.pyc,*.class
set nocompatible
set cpoptions+=I
set autoread
set autowrite
set fileformat=unix
set fileformats=unix
set nospell
set spelllang=en_us
set spellcapcheck=''
set encoding=utf-8
set listchars=tab:→\ ,trail:·
set ignorecase
set smartcase
set termguicolors

command! Rc source $MYVIMRC

" Not sure what this does...
autocmd BufEnter * lcd %:p:h

" Text Editing {{{1
" ============
retab
filetype plugin indent on

" Get word wrapping to work nicely.
set display+=lastline

autocmd FileType c,cpp set comments^=:///
autocmd FileType c,cpp set comments^=://!

command! R 0r
let g:LargeFile=2500

" Text Formatting {{{1
" ===============
set backspace=indent,eol,start
set formatoptions=t,croq,wnl
set shortmess+=I
set textwidth=79
set nowrap
set linebreak
set nonumber
set breakindent
set breakindentopt=sbr,shift:4
set showbreak=→\ 

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab

let &formatlistpat='^\s*\[\?\([0-9]\+\|[a-z]\|[iv]\+\)[\].:)}]\s\+\|^\s*[-*]#\?\s\+\|^\.\.\s\|^\s*\[[Xx ]\]\s'

autocmd FileType gitcommit set textwidth=72

" Text Searching {{{1
" ==============
set gdefault
set incsearch
set nohlsearch

" User Interface {{{1
" ==============
set mouse=
set mousehide
set guioptions=ic
set guifont=Monospace\ 10
set laststatus=2
set showcmd
set ruler

" nvim-qt
if exists(':GuiFont')
  GuiFont Monospace:h10
endif
if exists(':GuiTabline')
  GuiTabline 0
endif

set foldmethod=marker
set scrolloff=0
set sidescroll=0
set sidescrolloff=0
set lazyredraw

if has('gui_running')
  set background=light
else
  set background=dark
endif
set t_Co=256

function! FoldHighlight(level)
    return hlID('Folded' . a:level)
endfunction 

syntax enable
silent! set foldhighlight=FoldHighlight(v:foldlevel)

" Don't actually write the buffer if nothing has changed.
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("w", "up")
call SetupCommandAlias("wq", "x")

" Sometimes I accidentally type upper case letters in these commands, and 
" that's ok.  Map to up/x so that my compulsive saving doesn't cause things to 
" recompile unnecesarily.
command! W up
command! Q q
command! Wq x
command! WQ x

"set printdevice=HomePrinter

"let &printexpr="(v:cmdarg=='' ? ".
"    \"system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice)".
"    \". ' ' . v:fname_in) . delete(v:fname_in) + v:shell_error".
"    \" : system('mv '.v:fname_in.' '.v:cmdarg) + v:shell_error)"

" Miscellaneous {{{1
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" vim: nofoldenable
