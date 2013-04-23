if has('win32')
    let MYVIMRC = expand($VIM) . "/vimfiles/vimrc"
else
    let MYVIMRC = "~/.vim/vimrc"
endif
exe ":source " . MYVIMRC

