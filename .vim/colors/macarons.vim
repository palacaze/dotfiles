" Vim color file - macarons.vim
" Author: Pierre-Antoine Lacaze


" Set background first
set background=dark
hi clear

if version > 580
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="macarons"

" Setting normal before any other highlight group is a good idea
hi Normal          ctermfg=248      ctermbg=234                    guifg=#a8a8a8  guibg=#1c1c1c

set background=dark

hi Boolean         ctermfg=135                                     guifg=#af5fff
hi Character       ctermfg=143                                     guifg=#afaf5f
hi Number          ctermfg=33                                      guifg=#0087ff
hi String          ctermfg=179                                     guifg=#d7af5f
hi Conditional     ctermfg=196                    cterm=bold       guifg=#ff0000                 gui=bold
hi Constant        ctermfg=106                    cterm=bold       guifg=#87af00                 gui=bold
hi Cursor          ctermfg=bg       ctermbg=33                     guifg=bg       guibg=#0087ff
hi Debug           ctermfg=225                    cterm=bold       guifg=#ffd7ff                 gui=bold
hi Define          ctermfg=81                                      guifg=#5fd7ff
hi Delimiter       ctermfg=241                                     guifg=#626262

hi DiffAdd         ctermfg=77       ctermbg=none  cterm=none       guifg=#5fd75f  guibg=bg       gui=none
hi DiffDelete      ctermfg=202      ctermbg=none  cterm=none       guifg=#ff5f00  guibg=bg       gui=none
hi DiffChange      ctermfg=81       ctermbg=none  cterm=none       guifg=#5fd7ff  guibg=bg       gui=none
hi DiffText        ctermfg=229      ctermbg=none  cterm=bold       guifg=#ffffaf  guibg=bg       gui=bold
hi diffLine        ctermfg=142                    cterm=bold       guifg=#afaf00                 gui=bold
hi diffFile        ctermfg=135                                     guifg=#af5fff
hi diffSubname     ctermfg=218                                     guifg=#ffafd7

hi Directory       ctermfg=118                    cterm=bold       guifg=#87ff00                 gui=bold
hi Error           ctermfg=196      ctermbg=none                   guifg=#ff0000  guibg=bg  
hi ErrorMsg        ctermfg=199      ctermbg=none  cterm=bold       guifg=#ff00af  guibg=bg       gui=bold
hi WarningMsg      ctermfg=202      ctermbg=none  cterm=bold       guifg=#ff5f00  guibg=bg       gui=bold
hi Exception       ctermfg=118                    cterm=bold       guifg=#87ff00                 gui=bold
hi Float           ctermfg=135                                     guifg=#af5fff
hi FoldColumn      ctermfg=67       ctermbg=none  cterm=none       guifg=#5f87af  guibg=bg       gui=none
hi Folded          ctermfg=67       ctermbg=none  cterm=bold       guifg=#5f87af  guibg=bg       gui=bold
hi Function        ctermfg=118                                     guifg=#87ff00
hi Identifier      ctermfg=149                                     guifg=#afd75f
hi Ignore          ctermfg=237      ctermbg=none                   guifg=#3a3a3a  guibg=bg
hi IncSearch       ctermfg=16       ctermbg=184   cterm=italic     guifg=#000000  guibg=#d7d700  gui=italic

hi Keyword         ctermfg=111                    cterm=bold       guifg=#87afff                 gui=bold
hi Label           ctermfg=229                    cterm=none       guifg=#ffffaf                 gui=none
hi Macro           ctermfg=193                                     guifg=#d7ffaf
hi SpecialKey      ctermfg=81                                      guifg=#5fd7ff

hi MatchParen      ctermfg=161      ctermbg=none  cterm=bold       guifg=#d7005f  guibg=bg       gui=bold
hi ModeMsg         ctermfg=215                                     guifg=#ffaf5f
hi MoreMsg         ctermfg=215                                     guifg=#ffaf5f
hi Operator        ctermfg=148                                     guifg=#afd700

" complete menu
hi Pmenu           ctermfg=252      ctermbg=237   cterm=none       guifg=#d0d0d0  guibg=#3a3a3a  gui=none
hi PmenuSel        ctermfg=252      ctermbg=25    cterm=bold       guifg=#d0d0d0  guibg=#005faf  gui=bold
hi PmenuSbar       ctermfg=fg       ctermbg=240   cterm=none       guifg=fg       guibg=#585858  gui=none
hi PmenuThumb      ctermfg=fg       ctermbg=246   cterm=none       guifg=fg       guibg=#949494  gui=none

hi PreCondit       ctermfg=118                    cterm=bold       guifg=#87ff00                 gui=bold
hi PreProc         ctermfg=218                                     guifg=#ffafd7
hi Question        ctermfg=81                                      guifg=#5fd7ff
hi Repeat          ctermfg=161                    cterm=bold       guifg=#d7005f                 gui=bold
hi Search          ctermfg=16       ctermbg=40    cterm=none       guifg=#000000  guibg=#00d700  gui=none

" marks column
hi SignColumn      ctermfg=118      ctermbg=none                   guifg=#87ff00  guibg=bg  
hi SpecialChar     ctermfg=161                    cterm=bold       guifg=#d7005f                 gui=bold
hi SpecialComment  ctermfg=245                    cterm=bold       guifg=#8a8a8a                 gui=bold
hi Special         ctermfg=81       ctermbg=none                   guifg=#5fd7ff  guibg=bg  
hi SpecialKey      ctermfg=245                                     guifg=#8a8a8a

hi SpellBad        ctermfg=196      ctermbg=bg    cterm=bold       guifg=#ff0000  guibg=bg       gui=bold
hi SpellCap        ctermfg=94       ctermbg=bg    cterm=bold       guifg=#875f00  guibg=bg       gui=bold
hi SpellRare       ctermfg=96       ctermbg=bg    cterm=bold       guifg=#875f87  guibg=bg       gui=bold
hi SpellLocal      ctermfg=124      ctermbg=bg    cterm=bold       guifg=#af0000  guibg=bg       gui=bold

hi Statement       ctermfg=172                    cterm=bold       guifg=#d78700                 gui=bold
hi StatusLine      ctermfg=252      ctermbg=25    cterm=bold       guifg=#d0d0d0  guibg=#005faf  gui=bold
hi StatusLineNC    ctermfg=237      ctermbg=252                    guifg=#3a3a3a  guibg=#d0d0d0
hi StorageClass    ctermfg=208                                     guifg=#ff8700
hi Structure       ctermfg=81                                      guifg=#5fd7ff
hi Tag             ctermfg=161                                     guifg=#d7005f
hi Title           ctermfg=39                     cterm=bold       guifg=#00afff                 gui=bold
hi Subtitle        ctermfg=149                    cterm=bold       guifg=#afd75f                 gui=bold
hi Todo            ctermfg=160      ctermbg=none  cterm=bold       guifg=#d70000  guibg=bg       gui=bold

hi Typedef         ctermfg=81                                      guifg=#5fd7ff
hi Type            ctermfg=166                    cterm=none       guifg=#d75f00                 gui=none
hi Underlined      ctermfg=106                    cterm=underline  guifg=#87af00                 gui=underline

hi VertSplit       ctermfg=244      ctermbg=none  cterm=none       guifg=#808080  guibg=bg       gui=none
hi VisualNOS                        ctermbg=238                                   guibg=#444444
hi Visual                           ctermbg=241                                   guibg=#626262
hi WildMenu        ctermfg=81       ctermbg=bg                     guifg=#5fd7ff  guibg=bg

hi Comment         ctermfg=137                                     guifg=#af875f
hi ColorColumn                      ctermbg=235                                   guibg=#262626
hi CursorLine                       ctermbg=241   cterm=none                      guibg=#626262  gui=none
hi CursorColumn                     ctermbg=241                                   guibg=#626262
hi LineNr          ctermfg=241      ctermbg=none                   guifg=#626262  guibg=bg  
hi NonText         ctermfg=237      ctermbg=none  cterm=none       guifg=#3a3a3a  guibg=bg       gui=none

hi TabLine         ctermfg=fg       ctermbg=237   cterm=none       guifg=fg       guibg=#3a3a3a  gui=none
hi TabLineSel      ctermfg=252      ctermbg=25    cterm=bold       guifg=#d0d0d0  guibg=#005faf  gui=bold
hi TabLineFill     ctermfg=fg       ctermbg=bg    cterm=none       guifg=fg       guibg=bg       gui=none

hi User1           ctermfg=149                    cterm=bold       guifg=#afd75f                 gui=bold
hi User2           ctermfg=172                    cterm=bold       guifg=#d78700                 gui=bold

hi Blue            ctermfg=blue                                    guifg=#729fcf
hi Cyan            ctermfg=cyan                                    guifg=#05d2c1
hi Green           ctermfg=green                                   guifg=#73d216
hi Magenta         ctermfg=magenta                                 guifg=#75507b
hi Red             ctermfg=red                                     guifg=#ef2929
hi White           ctermfg=white                                   guifg=#eeeeec
hi Yellow          ctermfg=yellow                                  guifg=#edd400


hi link diffAdded DiffAdd
hi link gitDiffStatAdd DiffAdd
hi link diffRemoved DiffDelete
hi link gitDiffStatDelete DiffDelete
