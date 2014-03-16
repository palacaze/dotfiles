if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufNewFile,BufRead *.cc,*.hh,*.h     setfiletype cpp
    au! BufNewFile,BufRead *.cu,*cuh         setfiletype cuda.cpp
    au! BufNewFile,BufRead *.colors          setfiletype xdefaults
    au! BufNewFile,BufRead *.ispc            setfiletype ispc
    au! BufNewFile,BufRead *.pro,*.pri,*.prf setfiletype qmake
    au! BufNewFile,BufRead *.notes           setfiletype notes
augroup END

