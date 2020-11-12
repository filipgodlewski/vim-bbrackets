if exists("g:loaded_bbrackets")
    finish
endif
let g:loaded_bbrackets = 1

nnoremap <silent> <Plug>ChangeInsideRound :<C-U>call bbrackets#change("(", ")", "Round")<CR>
nnoremap <silent> <Plug>DeleteInsideRound :<C-U>call bbrackets#delete("(", ")", v:count1, "Round")<CR>
nnoremap <silent> <Plug>ChangeInsideSquare :<C-U>call bbrackets#change("[", "]", "Square")<CR>
nnoremap <silent> <Plug>DeleteInsideSquare :<C-U>call bbrackets#delete("[", "]", v:count1, "Square")<CR>
nnoremap <silent> <Plug>ChangeInsideCurly :<C-U>call bbrackets#change("{", "}", "Curly")<CR>
nnoremap <silent> <Plug>DeleteInsideCurly :<C-U>call bbrackets#delete("{", "}", v:count1, "Curly")<CR>

nmap ci( <Plug>ChangeInsideRound
nmap ci) <Plug>ChangeInsideRound
nmap ci[ <Plug>ChangeInsideSquare
nmap ci] <Plug>ChangeInsideSquare
nmap ci{ <Plug>ChangeInsideCurly
nmap ci} <Plug>ChangeInsideCurly

nmap di( <Plug>DeleteInsideRound
nmap di) <Plug>DeleteInsideRound
nmap di[ <Plug>DeleteInsideSquare
nmap di] <Plug>DeleteInsideSquare
nmap di{ <Plug>DeleteInsideCurly
nmap di} <Plug>DeleteInsideCurly

if &mps =~ "<:>"
    nnoremap <silent> <Plug>ChangeInsideAngle :<C-U>call bbrackets#change("<", ">", "Angle")<CR>
    nnoremap <silent> <Plug>DeleteInsideAngle :<C-U>call bbrackets#delete("<", ">", v:count1, "Angle")<CR>

    nmap ci< <Plug>ChangeInsideAngle
    nmap ci> <Plug>ChangeInsideAngle

    nmap di< <Plug>DeleteInsideAngle
    nmap di> <Plug>DeleteInsideAngle
endif
