if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    autocmd BufRead,BufNewFile CMakeLists.txt setfiletype cmake
    autocmd BufRead,BufNewFile *.dox          setfiletype conf
    autocmd BufRead,BufNewFile *.html         setfiletype sgml
    autocmd BufRead,BufNewFile *.ihh          setfiletype cpp
    autocmd BufRead,BufNewFile *.lit          setfiletype literature
    autocmd BufRead,BufNewFile *.md           setfiletype markdown
    autocmd BufRead,BufNewFile *.mdp          setfiletype mdp
    autocmd BufRead,BufNewFile *.mutt         setfiletype muttrc
    autocmd BufRead,BufNewFile *.pml          setfiletype pymol
    autocmd BufRead,BufNewFile *.sh           setfiletype zsh
    autocmd BufRead,BufNewFile *.tex          setfiletype tex
    autocmd BufRead,BufNewFile *.txt          setfiletype rst
    autocmd BufRead,BufNewFile *.xml          setfiletype sgml
augroup end

