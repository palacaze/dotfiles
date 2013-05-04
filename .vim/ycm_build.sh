TMP_DIR=/tmp/_build_ycm_

mkdir "$TMP_DIR" && cd "$TMP_DIR"
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON ~/.vim/bundle/YouCompleteMe/cpp
make -j6
rm -rf "$TMP_DIR"
