" Vim color file - SolarizedDark_modified
" Generated by http://bytefluent.com/vivify 2023-03-05
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "SolarizedDark_modified"

hi Normal guifg=#dbfcff guibg=#002b36 guisp=#002b36 gui=NONE ctermfg=195 ctermbg=23 cterm=NONE
"hi clear -- no settings --
hi IncSearch guifg=#ff601c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#fff9e4 guibg=#073642 guisp=#073642 gui=NONE ctermfg=230 ctermbg=23 cterm=NONE
hi SignColumn guifg=#b0c7c9 guibg=#bebebe guisp=#bebebe gui=NONE ctermfg=152 ctermbg=7 cterm=NONE
hi SpecialComment guifg=#ff3936 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Typedef guifg=#e9af00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Title guifg=#ff601c guibg=NONE guisp=NONE gui=bold ctermfg=202 ctermbg=NONE cterm=bold
hi Folded guifg=#b0c7c9 guibg=#073642 guisp=#073642 gui=bold ctermfg=152 ctermbg=23 cterm=bold
hi PreCondit guifg=#ff601c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi Include guifg=#ff601c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#809fa9 guibg=#eee8d5 guisp=#eee8d5 gui=bold ctermfg=109 ctermbg=230 cterm=bold
hi StatusLineNC guifg=#8dabb7 guibg=#073642 guisp=#073642 gui=NONE ctermfg=109 ctermbg=23 cterm=NONE
hi CTagsMember guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi NonText guifg=#8dabb7 guibg=NONE guisp=NONE gui=bold ctermfg=109 ctermbg=NONE cterm=bold
hi CTagsGlobalConstant guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi DiffText guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi ErrorMsg guifg=#ff3936 guibg=#0000c0 guisp=#0000c0 gui=NONE ctermfg=13 ctermbg=4 cterm=NONE
hi Ignore guifg=#343434 guibg=NONE guisp=NONE gui=NONE ctermfg=236 ctermbg=NONE cterm=NONE
hi Debug guifg=#ff3936 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=#fff9e4 guibg=#839496 guisp=#839496 gui=NONE ctermfg=230 ctermbg=66 cterm=NONE
hi Identifier guifg=#2ea8ff guibg=NONE guisp=NONE gui=bold ctermfg=33 ctermbg=NONE cterm=bold
hi SpecialChar guifg=#ff3936 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Conditional guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#e9af00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Todo guifg=#ff419d guibg=#00ffff guisp=#00ffff gui=bold ctermfg=13 ctermbg=14 cterm=bold
hi Special guifg=#ff3936 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi LineNr guifg=#809fa9 guibg=#073642 guisp=#073642 gui=NONE ctermfg=109 ctermbg=23 cterm=NONE
hi StatusLine guifg=#c2d4d4 guibg=#073642 guisp=#073642 gui=bold ctermfg=152 ctermbg=23 cterm=bold
hi Label guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi CTagsImport guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=#809fa9 guibg=#eee8d5 guisp=#eee8d5 gui=NONE ctermfg=109 ctermbg=230 cterm=NONE
hi Search guifg=#e9af00 guibg=#00ffff guisp=#00ffff gui=NONE ctermfg=178 ctermbg=14 cterm=NONE
hi CTagsGlobalVariable guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi Delimiter guifg=#ff3936 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Statement guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#fcfeff guibg=#ff40ff guisp=#ff40ff gui=NONE ctermfg=195 ctermbg=13 cterm=NONE
hi EnumerationValue guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi Comment guifg=#809fa9 guibg=NONE guisp=NONE gui=italic ctermfg=109 ctermbg=NONE cterm=NONE
hi Character guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi Float guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi Number guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi Boolean guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi Operator guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi CursorLine guifg=#fcfeff guibg=#073642 guisp=#073642 gui=underline ctermfg=195 ctermbg=23 cterm=underline
hi Union guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=#b0c7c9 guibg=#073642 guisp=#073642 gui=underline ctermfg=152 ctermbg=23 cterm=underline
hi Question guifg=#38d4c7 guibg=NONE guisp=NONE gui=bold ctermfg=80 ctermbg=NONE cterm=bold
hi WarningMsg guifg=#ff3936 guibg=NONE guisp=NONE gui=bold ctermfg=13 ctermbg=NONE cterm=bold
hi VisualNOS guifg=#fcfeff guibg=#073642 guisp=#073642 gui=bold ctermfg=195 ctermbg=23 cterm=bold
hi DiffDelete guifg=#ff3936 guibg=#073642 guisp=#073642 gui=bold ctermfg=13 ctermbg=23 cterm=bold
hi ModeMsg guifg=#2ea8ff guibg=NONE guisp=NONE gui=bold ctermfg=33 ctermbg=NONE cterm=bold
hi CursorColumn guifg=#fcfeff guibg=#073642 guisp=#073642 gui=NONE ctermfg=195 ctermbg=23 cterm=NONE
hi Define guifg=#ff601c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi Function guifg=#2ea8ff guibg=NONE guisp=NONE gui=bold ctermfg=33 ctermbg=NONE cterm=bold
hi FoldColumn guifg=#b0c7c9 guibg=#073642 guisp=#073642 gui=NONE ctermfg=152 ctermbg=23 cterm=NONE
hi PreProc guifg=#ff601c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi EnumerationName guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi Visual guifg=#809fa9 guibg=#002b36 guisp=#002b36 gui=NONE ctermfg=109 ctermbg=23 cterm=NONE
hi MoreMsg guifg=#2ea8ff guibg=NONE guisp=NONE gui=NONE ctermfg=33 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#fcfeff guibg=#ff6060 guisp=#ff6060 gui=NONE ctermfg=195 ctermbg=9 cterm=NONE
hi VertSplit guifg=#8dabb7 guibg=#657b83 guisp=#657b83 gui=NONE ctermfg=109 ctermbg=66 cterm=NONE
hi Exception guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi Keyword guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi Type guifg=#e9af00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi DiffChange guifg=#e9af00 guibg=#073642 guisp=#073642 gui=bold ctermfg=178 ctermbg=23 cterm=bold
hi Cursor guifg=#00556a guibg=#839496 guisp=#839496 gui=NONE ctermfg=23 ctermbg=66 cterm=NONE
hi SpellLocal guifg=#fcfeff guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=195 ctermbg=11 cterm=NONE
hi Error guifg=#ff3936 guibg=#8080ff guisp=#8080ff gui=bold ctermfg=13 ctermbg=12 cterm=bold
hi PMenu guifg=#b0c7c9 guibg=#073642 guisp=#073642 gui=NONE ctermfg=152 ctermbg=23 cterm=NONE
hi SpecialKey guifg=#8dabb7 guibg=#073642 guisp=#073642 gui=bold ctermfg=109 ctermbg=23 cterm=bold
hi Constant guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi DefinedName guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi Tag guifg=#ff3936 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi String guifg=#38d4c7 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=#b0c7c9 guibg=#002b36 guisp=#002b36 gui=NONE ctermfg=152 ctermbg=23 cterm=NONE
hi MatchParen guifg=#ff3936 guibg=#586e75 guisp=#586e75 gui=bold ctermfg=13 ctermbg=66 cterm=bold
hi LocalVariable guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi Repeat guifg=#96d209 guibg=NONE guisp=NONE gui=NONE ctermfg=112 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#fcfeff guibg=#8080ff guisp=#8080ff gui=NONE ctermfg=195 ctermbg=12 cterm=NONE
hi CTagsClass guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi Directory guifg=#2ea8ff guibg=NONE guisp=NONE gui=NONE ctermfg=33 ctermbg=NONE cterm=NONE
hi Structure guifg=#e9af00 guibg=NONE guisp=NONE gui=NONE ctermfg=178 ctermbg=NONE cterm=NONE
hi Macro guifg=#ff601c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi Underlined guifg=#898ff8 guibg=NONE guisp=NONE gui=underline ctermfg=105 ctermbg=NONE cterm=underline
hi DiffAdd guifg=#96d209 guibg=#073642 guisp=#073642 gui=bold ctermfg=112 ctermbg=23 cterm=bold
hi TabLine guifg=#b0c7c9 guibg=#073642 guisp=#073642 gui=underline ctermfg=152 ctermbg=23 cterm=underline
hi cursorim guifg=#737373 guibg=#8b8bff guisp=#8b8bff gui=NONE ctermfg=243 ctermbg=105 cterm=NONE
hi lcursor guifg=#737373 guibg=#8fff8b guisp=#8fff8b gui=NONE ctermfg=243 ctermbg=120 cterm=NONE
hi mbenormal guifg=#ffebd5 guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=230 ctermbg=237 cterm=NONE
hi perlspecialstring guifg=#eb9dff guibg=#404040 guisp=#404040 gui=NONE ctermfg=219 ctermbg=238 cterm=NONE
hi doxygenspecial guifg=#ffd191 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi mbechanged guifg=#ffffff guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=15 ctermbg=237 cterm=NONE
hi mbevisiblechanged guifg=#ffffff guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=15 ctermbg=60 cterm=NONE
hi doxygenparam guifg=#ffd191 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygensmallspecial guifg=#ffd191 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygenprev guifg=#ffd191 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi perlspecialmatch guifg=#eb9dff guibg=#404040 guisp=#404040 gui=NONE ctermfg=219 ctermbg=238 cterm=NONE
hi cformat guifg=#eb9dff guibg=#404040 guisp=#404040 gui=NONE ctermfg=219 ctermbg=238 cterm=NONE
hi doxygenspecialmultilinedesc guifg=#e07a0d guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#8a96ff guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#ffad61 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#fffffd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=230 ctermbg=60 cterm=NONE
hi user2 guifg=#9494d4 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=104 ctermbg=60 cterm=NONE
hi user1 guifg=#00ff8c guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
hi doxygenspecialonelinedesc guifg=#e07a0d guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#e0a029 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#eb9dff guibg=#404040 guisp=#404040 gui=NONE ctermfg=219 ctermbg=238 cterm=NONE
hi javadocseetag guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi number guifg=#ff73fd guibg=NONE guisp=NONE gui=NONE ctermfg=207 ctermbg=NONE cterm=NONE
hi keyword guifg=#97cdff guibg=NONE guisp=NONE gui=NONE ctermfg=117 ctermbg=NONE cterm=NONE
hi rubyescape guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi type guifg=#ffffb6 guibg=NONE guisp=NONE gui=NONE ctermfg=229 ctermbg=NONE cterm=NONE
hi identifier guifg=#c7c6ff guibg=NONE guisp=NONE gui=NONE ctermfg=189 ctermbg=NONE cterm=NONE
hi conditional guifg=#7fbfff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi rubystringdelimiter guifg=#4d9a4d guibg=NONE guisp=NONE gui=NONE ctermfg=71 ctermbg=NONE cterm=NONE
hi rubyregexpdelimiter guifg=#ff8000 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi rubyinterpolationdelimiter guifg=#00d4d4 guibg=NONE guisp=NONE gui=NONE ctermfg=44 ctermbg=NONE cterm=NONE
hi rubycontrol guifg=#7fbfff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi rubyregexp guifg=#e5b34f guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi operator guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi longlinewarning guifg=NONE guibg=#371F1C guisp=#371F1C gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi pythonbuiltin guifg=#b0c7c9 guibg=NONE guisp=NONE gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi phpstringdouble guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi htmltagname guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi javascriptstrings guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi htmlstring guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE
hi phpstringsingle guifg=#fcfeff guibg=NONE guisp=NONE gui=NONE ctermfg=195 ctermbg=NONE cterm=NONE

