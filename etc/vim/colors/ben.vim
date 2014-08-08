" Maintainer:   Benjamin Nolan <ben.nolan@gmail.com>
" Last Change:  2008-Mar-19
"
" This colourscheme has been tailored for terminals with a black background.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

let colors_name = "ben"

" Custom colourscheme information
hi Comment ctermfg=Magenta guifg=Magenta
hi SpecialComment ctermfg=DarkCyan guifg=DarkCyan

hi Constant ctermfg=Yellow guifg=Yellow
hi String ctermfg=DarkRed guifg=DarkRed
hi Character ctermfg=DarkRed guifg=DarkRed
hi Number ctermfg=DarkRed guifg=DarkRed

hi Function ctermfg=DarkCyan guifg=DarkCyan
hi Identifier ctermfg=DarkCyan guifg=DarkCyan
hi Keyword ctermfg=Yellow guifg=Yellow

hi Statement ctermfg=Yellow guifg=Yellow
hi Conditional ctermfg=Yellow guifg=Yellow
hi Operator ctermfg=DarkYellow guifg=DarkYellow
hi Type ctermfg=DarkGreen guifg=DarkGreen

hi Todo ctermfg=Yellow ctermbg=Blue guifg=Yellow guibg=Blue
