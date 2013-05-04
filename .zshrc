# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gentoo"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="false"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git extract fasd zsh-syntax-highlighting)

# Use EMACS-style keybindings despite my having EDITOR set to vim
bindkey -e


source $ZSH/oh-my-zsh.sh


# no beep ever
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# Confirm 'rm *'
unsetopt rm_star_silent

# completion options
setopt auto_remove_slash
unsetopt glob_dots
setopt chase_links
setopt auto_cd
setopt append_history
setopt mark_dirs
setopt auto_param_slash
setopt numeric_glob_sort
# setopt inc_append_history

setopt extended_glob

unsetopt extended_history
setopt hist_verify
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_save_no_dups
setopt hist_find_no_dups

# I hate automatic correction
export CORRECT_IGNORE='[._]'
setopt correct
unsetopt correct_all


# history
export HISTORY=5000
export SAVEHIST=5000
export HISTFILESIZE=5000
export HISTFILE=$HOME/.history

export BROWSER='firefox'
export EDITOR=vim
export PAGER=$HOME/bin/vimpager
export MANPAGER=$PAGER
alias less=$PAGER
alias zless=$PAGER


# Color
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dir_colors ]; then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]; then
    eval "`dircolors /etc/dir_colors`"
  else
    eval "`dircolors`"
  fi
fi

# colors in linux TTY console
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0353535" #
    echo -en "\e]P1D81860" #
    echo -en "\e]P2B7CE42" #
    echo -en "\e]P3FEA63C" #
    echo -en "\e]P46F99B4" #
    echo -en "\e]P58B7B8B" #
    echo -en "\e]P6A7A15E" #
    echo -en "\e]P7DDDDDD" #
    echo -en "\e]P8666666" #
    echo -en "\e]P9F00060" #
    echo -en "\e]PABDE077" #
    echo -en "\e]PBFFE863" #
    echo -en "\e]PC7C96B0" #
    echo -en "\e]PDD8BFD8" #
    echo -en "\e]PEF0E68C" #
    echo -en "\e]PFFFFFFF" #
    clear # Clear artifacts
fi


ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='bold'


export PATH="$HOME/travail/software/mxe/usr/bin:$PATH"
export C_INCLUDE_PATH="$HOME/local/include"
export CPLUS_INCLUDE_PATH="$HOME/local/include"
export LIBRARY_PATH="$HOME/local/lib"
export PATH="$HOME/local/bin:$PATH"
export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig:$PKG_CONFIG_PATH"


alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'
alias cp='cp --interactive'
alias mv='mv --interactive'
# alias rm='rm --interactive'
alias nice="ionice -c2 -n7 nice"
alias top='htop'
alias tmux='tmux -2 -u'
alias scpresume="rsync --partial --progress --rsh=ssh"
alias m='ncmpcpp'
alias vv='vim ~/.vim/vimrc'
alias vz='vim ~/.zshrc'
alias vx='vim ~/.xmonad/xmonad.hs'
alias vs='vim ~/.xsession'
alias vX='vim ~/.Xresources'
alias vt='vim ~/.tmux.conf'
alias t='thunar&'


if [ -s ~/gentoo/scripts ] ; then
    source ~/gentoo/scripts
fi


# fasd
eval "$(fasd --init auto)"
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open


# keys
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]] && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]] && bindkey "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]] && bindkey "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]] && bindkey "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]] && bindkey "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]] && bindkey "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]] && bindkey "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" history-beginning-search-forward


# functions
function pdf_compress() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$2" "$1"
}


function gdb_get_backtrace() {
    local exe=$1
    local core=$2

    gdb ${exe} \
        --core ${core} \
        --batch \
        --quiet \
        -ex "thread apply all bt full" \
        -ex "quit"
}
