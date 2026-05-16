" cp2077.vim — Cyberpunk 2077 Vim/Neovim color scheme
" Merged from: Cyberpunk-Neon (Roboron3042) + CP2077 design tokens
" Palette: #FCEE0C yellow · #00FFFF cyan · #FF003C red
"          #FF6B35 orange · #00FF9F green · #000b1e bg · #C0C0C0 fg
"
" Install (Vim):    cp cp2077.vim ~/.vim/colors/cp2077.vim
"                   :colorscheme cp2077
" Install (Neovim): cp cp2077.vim ~/.config/nvim/colors/cp2077.vim
"                   colorscheme cp2077  (in init.vim/init.lua)

hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "cp2077"

" ── 256-colour / true-colour ──────────────────────────────────────
if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")

  set background=dark

  " Core
  hi Normal         ctermbg=233 ctermfg=44  cterm=NONE guibg=#000b1e guifg=#00FFFF gui=NONE
  hi NonText        ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE    guifg=#2A2A2A gui=NONE
  hi EndOfBuffer    ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE    guifg=#2A2A2A gui=NONE

  " Cursor / line
  hi Cursor         ctermbg=NONE ctermfg=220 cterm=NONE guibg=NONE    guifg=#FCEE0C gui=NONE
  hi CursorLine     ctermbg=234  ctermfg=NONE cterm=NONE guibg=#111108 guifg=NONE   gui=NONE
  hi CursorLineNr   ctermbg=234  ctermfg=220  cterm=bold guibg=#111108 guifg=#FCEE0C gui=bold
  hi CursorColumn   ctermbg=234  ctermfg=NONE cterm=NONE guibg=#111108 guifg=NONE   gui=NONE
  hi LineNr         ctermbg=NONE ctermfg=240  cterm=NONE guibg=NONE    guifg=#2A2A2A gui=NONE
  hi ColorColumn    ctermbg=234  ctermfg=NONE cterm=NONE guibg=#111108 guifg=NONE   gui=NONE

  " Selection / search
  hi Visual         ctermbg=235  ctermfg=220  cterm=bold guibg=#1A1800 guifg=#FCEE0C gui=bold
  hi Search         ctermbg=220  ctermfg=233  cterm=bold guibg=#FCEE0C guifg=#000b1e gui=bold
  hi IncSearch      ctermbg=220  ctermfg=233  cterm=NONE guibg=#FCEE0C guifg=#000b1e gui=NONE
  hi MatchParen     ctermbg=24   ctermfg=44   cterm=bold guibg=#003050 guifg=#00FFFF gui=bold

  " Syntax — keywords / control flow
  hi Statement      ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Keyword        ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Conditional    ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Repeat         ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Operator       ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Exception      ctermbg=NONE ctermfg=196  cterm=bold guibg=NONE   guifg=#FF003C gui=bold

  " Syntax — types / identifiers
  hi Type           ctermbg=NONE ctermfg=44   cterm=bold guibg=NONE   guifg=#00FFFF gui=bold
  hi Identifier     ctermbg=NONE ctermfg=44   cterm=NONE guibg=NONE   guifg=#00FFFF gui=NONE
  hi Function       ctermbg=NONE ctermfg=44   cterm=bold guibg=NONE   guifg=#00FFFF gui=bold
  hi PreProc        ctermbg=NONE ctermfg=208  cterm=bold guibg=NONE   guifg=#FF6B35 gui=bold
  hi Macro          ctermbg=NONE ctermfg=208  cterm=bold guibg=NONE   guifg=#FF6B35 gui=bold
  hi Special        ctermbg=NONE ctermfg=208  cterm=NONE guibg=NONE   guifg=#FF6B35 gui=NONE

  " Syntax — literals
  hi String         ctermbg=NONE ctermfg=71   cterm=NONE guibg=NONE   guifg=#00FF9F gui=NONE
  hi Constant       ctermbg=NONE ctermfg=208  cterm=NONE guibg=NONE   guifg=#FF6B35 gui=NONE
  hi Number         ctermbg=NONE ctermfg=208  cterm=NONE guibg=NONE   guifg=#FF6B35 gui=NONE
  hi Boolean        ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Character      ctermbg=NONE ctermfg=71   cterm=NONE guibg=NONE   guifg=#00FF9F gui=NONE

  " Comments
  hi Comment        ctermbg=NONE ctermfg=240  cterm=NONE guibg=NONE   guifg=#555555 gui=NONE
  hi Todo           ctermbg=220  ctermfg=233  cterm=bold guibg=#FCEE0C guifg=#000b1e gui=bold

  " Error / warning
  hi Error          ctermbg=NONE ctermfg=196  cterm=NONE guibg=NONE   guifg=#FF003C gui=NONE
  hi ErrorMsg       ctermbg=196  ctermfg=233  cterm=bold guibg=#FF003C guifg=#000b1e gui=bold
  hi WarningMsg     ctermbg=NONE ctermfg=208  cterm=NONE guibg=NONE   guifg=#FF6B35 gui=NONE

  " Status / tab bar
  hi StatusLine     ctermbg=220  ctermfg=233  cterm=bold guibg=#FCEE0C guifg=#000000 gui=bold
  hi StatusLineNC   ctermbg=234  ctermfg=240  cterm=NONE guibg=#1A1A1A guifg=#555555 gui=NONE
  hi TabLine        ctermbg=234  ctermfg=240  cterm=NONE guibg=#111108 guifg=#555555 gui=NONE
  hi TabLineFill    ctermbg=234  ctermfg=240  cterm=NONE guibg=#111108 guifg=#555555 gui=NONE
  hi TabLineSel     ctermbg=220  ctermfg=233  cterm=bold guibg=#FCEE0C guifg=#000000 gui=bold
  hi VertSplit      ctermbg=234  ctermfg=234  cterm=NONE guibg=#1A1A1A guifg=#1A1A1A gui=NONE
  hi WinSeparator   ctermbg=NONE ctermfg=240  cterm=NONE guibg=NONE    guifg=#2A2A2A gui=NONE

  " Popup / completion menu
  hi Pmenu          ctermbg=234  ctermfg=44   cterm=NONE guibg=#111111 guifg=#00FFFF gui=NONE
  hi PmenuSel       ctermbg=220  ctermfg=233  cterm=bold guibg=#FCEE0C guifg=#000000 gui=bold
  hi PmenuSbar      ctermbg=234  ctermfg=NONE cterm=NONE guibg=#111111 guifg=NONE    gui=NONE
  hi PmenuThumb     ctermbg=220  ctermfg=233  cterm=NONE guibg=#FCEE0C guifg=#000000 gui=NONE

  " Diff
  hi DiffAdd        ctermbg=NONE ctermfg=71   cterm=NONE guibg=NONE   guifg=#00FF9F gui=NONE
  hi DiffAdded      ctermbg=NONE ctermfg=71   cterm=NONE guibg=NONE   guifg=#00FF9F gui=NONE
  hi DiffChange     ctermbg=NONE ctermfg=44   cterm=NONE guibg=NONE   guifg=#00FFFF gui=NONE
  hi DiffChanged    ctermbg=NONE ctermfg=44   cterm=NONE guibg=NONE   guifg=#00FFFF gui=NONE
  hi DiffDelete     ctermbg=NONE ctermfg=196  cterm=NONE guibg=NONE   guifg=#FF003C gui=NONE
  hi DiffRemoved    ctermbg=NONE ctermfg=196  cterm=NONE guibg=NONE   guifg=#FF003C gui=NONE
  hi DiffText       ctermbg=235  ctermfg=220  cterm=NONE guibg=#1A1800 guifg=#FCEE0C gui=NONE

  " Fold / sign column
  hi Folded         ctermbg=234  ctermfg=240  cterm=NONE guibg=#111111 guifg=#555555 gui=NONE
  hi FoldColumn     ctermbg=NONE ctermfg=220  cterm=NONE guibg=NONE    guifg=#FCEE0C gui=NONE
  hi SignColumn     ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE    guifg=NONE    gui=NONE

  " Spell
  hi SpellBad       ctermbg=196  ctermfg=233  cterm=NONE guibg=#FF003C guifg=#000b1e gui=undercurl guisp=#FF003C
  hi SpellCap       ctermbg=208  ctermfg=233  cterm=NONE guibg=#FF6B35 guifg=#000b1e gui=undercurl guisp=#FF6B35
  hi SpellLocal     ctermbg=44   ctermfg=233  cterm=NONE guibg=#00FFFF guifg=#000b1e gui=undercurl guisp=#00FFFF
  hi SpellRare      ctermbg=240  ctermfg=233  cterm=NONE guibg=#555555 guifg=#000b1e gui=undercurl guisp=#555555

  " Misc UI
  hi Title          ctermbg=NONE ctermfg=220  cterm=bold guibg=NONE   guifg=#FCEE0C gui=bold
  hi Directory      ctermbg=NONE ctermfg=44   cterm=bold guibg=NONE   guifg=#00FFFF gui=bold
  hi ModeMsg        ctermbg=NONE ctermfg=44   cterm=bold guibg=NONE   guifg=#00FFFF gui=bold
  hi MoreMsg        ctermbg=NONE ctermfg=44   cterm=bold guibg=NONE   guifg=#00FFFF gui=bold
  hi Question       ctermbg=NONE ctermfg=44   cterm=NONE guibg=NONE   guifg=#00FFFF gui=NONE
  hi Underlined     ctermbg=NONE ctermfg=44   cterm=underline guibg=NONE guifg=#00FFFF gui=underline
  hi WildMenu       ctermbg=220  ctermfg=233  cterm=bold guibg=#FCEE0C guifg=#000000 gui=bold
  hi SpecialKey     ctermbg=NONE ctermfg=71   cterm=NONE guibg=NONE   guifg=#00FF9F gui=NONE

  hi link Number      Constant
  hi link Float       Number
  hi link Include     PreProc
  hi link Define      Macro
  hi link StorageClass Type
  hi link Structure   Type
  hi link Typedef     Type
  hi link Label       Statement
  hi link htmlTagName PreProc

  " Terminal buffer palette
  let g:terminal_ansi_colors = [
    \ '#000b1e', '#FF003C', '#00FF9F', '#FCEE0C',
    \ '#003050', '#FF6B35', '#00FFFF', '#C0C0C0',
    \ '#555555', '#FF003C', '#00FF9F', '#FCEE0C',
    \ '#005faf', '#FF6B35', '#00FFFF', '#FFFFFF',
    \ ]

" ── 8-colour fallback ─────────────────────────────────────────────
elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
  set t_Co=16
  set background=dark

  hi Normal         ctermbg=black ctermfg=cyan   cterm=NONE
  hi Statement      ctermbg=NONE  ctermfg=yellow cterm=bold
  hi Keyword        ctermbg=NONE  ctermfg=yellow cterm=bold
  hi Type           ctermbg=NONE  ctermfg=cyan   cterm=bold
  hi Identifier     ctermbg=NONE  ctermfg=cyan   cterm=NONE
  hi Function       ctermbg=NONE  ctermfg=cyan   cterm=bold
  hi String         ctermbg=NONE  ctermfg=green  cterm=NONE
  hi Constant       ctermbg=NONE  ctermfg=darkyellow cterm=NONE
  hi Comment        ctermbg=NONE  ctermfg=blue   cterm=NONE
  hi Error          ctermbg=NONE  ctermfg=red    cterm=NONE
  hi ErrorMsg       ctermbg=red   ctermfg=black  cterm=bold
  hi Visual         ctermbg=darkyellow ctermfg=black cterm=bold
  hi Search         ctermbg=yellow ctermfg=black cterm=bold
  hi StatusLine     ctermbg=yellow ctermfg=black cterm=bold
  hi StatusLineNC   ctermbg=black  ctermfg=blue  cterm=NONE
  hi Pmenu          ctermbg=blue   ctermfg=cyan  cterm=NONE
  hi PmenuSel       ctermbg=yellow ctermfg=black cterm=bold
  hi LineNr         ctermbg=NONE   ctermfg=blue  cterm=NONE
  hi CursorLineNr   ctermbg=NONE   ctermfg=yellow cterm=bold
  hi TabLineSel     ctermbg=yellow ctermfg=black cterm=bold
  hi TabLine        ctermbg=black  ctermfg=blue  cterm=NONE
  hi TabLineFill    ctermbg=black  ctermfg=blue  cterm=NONE
  hi DiffAdd        ctermbg=NONE   ctermfg=green cterm=NONE
  hi DiffDelete     ctermbg=NONE   ctermfg=red   cterm=NONE
  hi Title          ctermbg=NONE   ctermfg=yellow cterm=bold
  hi WildMenu       ctermbg=yellow ctermfg=black cterm=bold
  hi Todo           ctermbg=yellow ctermfg=black cterm=bold
  hi link Number    Constant
endif
