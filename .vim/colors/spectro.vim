" Vim color file
" Maintainer:   Pierre-Antoine Lacaze <pa.lacaze@gmail.com>
" Last Change:  25-02-2008 14:40
" License:      GPLv2

" To install, copy to ~/.vim/colors directory. Then :colorscheme spectro

" spectro is a colorscheme that lets you define the global saturation and
" the global lightness to be used for all the colors. The hue is then 
" defined on a per color basis
" hue, saturation and lightness shall be set between 0 and 255
" I shamelessly used inkscape colors algorithm for HSL -> RGB conversion

" The main interest is the ability to adapt to different screens
" by only changing the saturation and lightness in your vimrc :
" let g:spectro_saturation = 120
" let g:spectro_lightness = 160

set background=dark
hi clear          
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="spectro"

"{{{ Defaults
" default saturation value
if ! exists("g:spectro_saturation")
    let g:spectro_saturation = 130
else
    if g:spectro_saturation > 255
	let g:spectro_saturation = 255
    elseif g:spectro_saturation < 0
	let g:spectro_saturation = 0
    endif
endif

" default lightness value
if ! exists("g:spectro_lightness")
    let g:spectro_lightness = 130
else
    if g:spectro_lightness > 255
	let g:spectro_lightness = 255
    elseif g:spectro_lightness < 0
	let g:spectro_lightness = 0
    endif

endif
"}}}

"{{{ Functions
" function returning the hexadecimal value of an integer between 0 and 16
fun! Dec2hex(s)
    let str = "0123456789ABCDEF"
    return str[a:s]
endfunc

" function converting a (R,G,B) triplet into a "#rrggbb" string
fun! FormatRGB(rgb)
    let r1 = a:rgb[0] / 16
    let g1 = a:rgb[1] / 16
    let b1 = a:rgb[2] / 16
    let r2 = a:rgb[0] % 16
    let g2 = a:rgb[1] % 16
    let b2 = a:rgb[2] % 16
    return "#".Dec2hex(r1).Dec2hex(r2).Dec2hex(g1).Dec2hex(g2).Dec2hex(b1).Dec2hex(b2)
endfun

" function converting hue to RGB
fun! Hue2rgb(v1,v2,H)
    let v1 = a:v1
    let v2 = a:v2
    let H = a:H
    if H < 0 
	let H += 6 * 255
    elseif H > 6 * 255
	let H -= 6 * 255
    end

    if H < 255
	return (v1 * 255 + (v2 - v1) * H) / (255 * 255)
    elseif H < 3 * 255
	return v2 / 255
    elseif H < 4 * 255
	return (v1 * 255 + (v2 - v1) * (4 * 255 - H)) / (255 * 255)
    else
	return v1 / 255
    endif
endfun

" function converting a (H,S,L) triplet into a (R,G,B) triplet
fun! Hsl2rgb(h)
    let H = a:h
    let S = g:spectro_saturation
    let L = g:spectro_lightness
    if S == 0
	let RGB = [L,L,L]
    else
	let RGB = [0,0,0]
	if L < 128
	    let v2 = L * (255 + S)
	else
	    let v2 = 255* (L + S) - L * S
	endif
	let v1 = 2 * 255 * L - v2
	let RGB[0] = Hue2rgb(v1,v2,H * 6 + 2 * 255)
	let RGB[1] = Hue2rgb(v1,v2,H * 6)
	let RGB[2] = Hue2rgb(v1,v2,H * 6 - 2 * 255)
    endif
    return FormatRGB(RGB)
endfun
"}}}

"{{{ Colors definitions
" we choose the hue for each color to be used
" You may want to use inkscape to calibrate this
let white  = "#ffffff"
let black  = "#000000"
let gray   = "#dcdccc"
let dgray  = "#282828"
let dblue  = "#006060"
let c_comm = Hsl2rgb(71)
let c_spec = Hsl2rgb(27)
let c_numb = Hsl2rgb(128)
let c_iden = Hsl2rgb(42)
let c_stat = Hsl2rgb(212)
let c_prep = Hsl2rgb(8)
let c_erro = Hsl2rgb(0)
let c_curs = Hsl2rgb(58)
let c_visu = Hsl2rgb(223)
let c_tabl = Hsl2rgb(140)
let c_sepa = Hsl2rgb(150)
"}}}

" let's define colors
exe "hi Function        guifg=".c_sepa
exe "hi Comment		guifg=".c_comm."                        gui=none"
exe "hi Special		guifg=".c_spec."			gui=none"
exe "hi String		guifg=".c_spec."    guibg=".dgray."	gui=none"
exe "hi Constant	guifg=".c_spec."			gui=bold"
exe "hi Number		guifg=".c_numb
exe "hi Identifier	guifg=".c_iden
exe "hi Statement	guifg=".c_stat."			gui=none"
exe "hi PreProc		guifg=".c_prep."			gui=none"
exe "hi Type		guifg=".c_iden."			gui=none"
exe "hi Todo		guifg=".black ."    guibg=".c_iden."	gui=none"
exe "hi ErrorMsg	guifg=".white ."    guibg=".c_erro."	gui=none"
exe "hi MoreMsg		guifg=".white ."    guibg=".c_spec."	gui=none"
exe "hi Cursor		guifg=".black ."    guibg=".c_curs."	gui=none"
exe "hi WildMenu	guifg=".black ."    guibg=".c_curs."	gui=none"
exe "hi LineNr		guifg=".c_curs
exe "hi Normal		guifg=".gray  ."    guibg=".black
exe "hi Visual		guifg=".black ."    guibg=".c_spec
exe "hi Underlined	guifg=".gray  ."			gui=underline"
exe "hi VertSplit	guifg=".dblue ."    guibg=".gray
exe "hi TabLine		guifg=".gray  ."    guibg=".dblue ."	gui=none"
exe "hi TablineFill	guifg=".white ."    guibg=".black ."    gui=bold"
exe "hi TablineSel	guifg=".white ."    guibg=".c_tabl."	gui=none"
exe "hi User2		guifg=".white ."    guibg=".c_tabl."	gui=none"
exe "hi StatusLine	guifg=".white ."    guibg=".c_tabl."	gui=none"
exe "hi StatusLineNC	guifg=".gray  ."    guibg=".dblue ."	gui=none"
exe "hi Pmenu		guifg=".gray  ."    guibg=".dblue ."	gui=none"
exe "hi PmenuSel	guifg=".black ."    guibg=".c_tabl."	gui=none"
exe "hi PmenuSbar	guifg=".black ."    guibg=".gray  ."	gui=none"
exe "hi PmenuThumb	guifg=".black ."    guibg=".gray  ."	gui=none"
exe "hi Directory	guifg=".c_comm
exe "hi DiffAdd 	guifg=".c_comm."			gui=none"
exe "hi DiffChange	guifg=".c_iden."			gui=none"
exe "hi DiffDelete	guifg=".c_erro."			gui=none"
exe "hi DiffText	guifg=".c_numb."			gui=none"
exe "hi Folded		guifg=".c_tabl."    guibg=".black."     gui=none"

hi link SpecialChar	    String
hi link Tag		    Special
hi link Delimiter	    Special
hi link Character	    String
hi link SpecialKey	    Special
hi link cFormat		    String
hi link	cSpecialCharacter   String
hi link Debug		    Constant
hi link SpecialComment	    Constant
hi link Boolean		    Number
hi link Float		    Number
hi link NonText		    Number
" hi link Function	    Identifier
hi link Title		    Identifier
hi link Conditional	    Statement
hi link Repeat		    Statement
hi link Label		    Statement
hi link Operator	    Statement
hi link keyword		    Statement
hi link Exception	    Statement
hi link Include		    PreProc
hi link Define		    PreProc
hi link Macro		    PreProc
hi link PreCondit	    PreProc
hi link ModeMsg		    PreProc
hi link StorageClass	    Type
hi link Structure	    Type
hi link Typedef		    Type
hi link Search		    Todo
hi link IncSearch	    Todo
hi link	Error		    ErrorMsg
hi link WarningMsg	    MoreMsg
hi link Question	    LineNr
hi link StatusLineNC	    TabLine
hi link User2		    TabLineSel
" hi link DiffAdd	    DiffAdded
" hi link DiffChange	    DiffChanged
" hi link DiffDelete	    DiffRemoved
" hi link DiffText	    DiffLine
hi link FoldColumn	    Include

