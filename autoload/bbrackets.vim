if exists("g:loaded_bbrackets")
    finish
endif
let g:loaded_bbrackets = 1

function! s:delete_body(open, close)
    let l:current = strcharpart(getline('.')[col('.') - 1:], 0, 1)
    let l:current_and_next = strcharpart(getline('.')[col('.') - 1:], 0, 2)
    let l:last_two = strcharpart(getline('.')[col('.') - 2:], 0, 2)
    let l:has_pairs = searchpair(a:open, ".\+", a:close, "bcmW", "", line("w$")) > 0
    let l:is_eol = len(l:current_and_next) == 1
    let l:is_open_close = l:last_two == a:open.a:close
    if l:is_eol && l:is_open_close
        return 0
    elseif !(l:current == a:close && !l:is_open_close) || !l:has_pairs
        execute "normal! f".a:close
        if strcharpart(getline('.')[col('.') - 1:], 0, 1) != a:close
            execute "normal! %"
        endif
    endif
    execute "normal! di".a:open
    return 1
endfunction

function! s:has_pair(open, close)
    let l:before = strcharpart(getline('.')[col('.') - 1:], 0, 1)
    execute "normal! %"
    let l:after = strcharpart(getline('.')[col('.') - 1:], 0, 1)
    execute "normal! %"
    return l:before != l:after
endfunction

function! s:join_brackets(open, close)
    let l:last_two = strcharpart(getline('.')[col('.') - 2:], 0, 2)
    let l:current_and_next = strcharpart(getline('.')[col('.') - 1:], 0, 2)
    if l:last_two != a:open.a:close && l:current_and_next != a:open
        execute "normal! %"
    endif
    if strcharpart(getline('.')[col('.') - 1:], 0, 2) == a:open
        execute "normal! J"
    endif
endfunction

function! s:delete_space_between(open, close)
    if !(a:open == "(") && strcharpart(getline('.')[col('.') - 2:], 0, 2) == a:open." "
        execute "normal! x"
    endif
endfunction

function! bbrackets#delete(open, close, count)
    for i in range(1, a:count)
        if !s:delete_body(a:open, a:close)
            break
        endif
        if s:has_pair(a:open, a:close)
            call s:join_brackets(a:open, a:close)
            call s:delete_space_between(a:open, a:close)
        endif
    endfor
endfunction

function! bbrackets#change(open, close)
    call bbrackets#delete(a:open, a:close, 1)
    startinsert
endfunction

if exists("g:loaded_repeat")
    nn <silent> <Plug>ChangeInsideRound :<C-U>call bbrackets#change("(", ")") \| call repeat#set("\<Plug>ChangeInsideRound")<CR>
    nn <silent> <Plug>ChangeInsideSquare :<C-U>call bbrackets#change("[", "]") \| call repeat#set("\<Plug>ChangeInsideSquare")<CR>
    nn <silent> <Plug>ChangeInsideCurly :<C-U>call bbrackets#change("{", "}") \| call repeat#set("\<Plug>ChangeInsideCurly")<CR>
    nn <silent> <Plug>DeleteInsideRound :<C-U>call bbrackets#delete("(", ")", v:count1) \| call repeat#set("\<Plug>DeleteInsideRound")<CR>
    nn <silent> <Plug>DeleteInsideSquare :<C-U>call bbrackets#delete("[", "]", v:count1) \| call repeat#set("\<Plug>DeleteInsideSquare")<CR>
    nn <silent> <Plug>DeleteInsideCurly :<C-U>call bbrackets#delete("{", "}", v:count1) \| call repeat#set("\<Plug>DeleteInsideCurly")<CR>
else
    nn <silent> <Plug>ChangeInsideRound :<C-U>call bbrackets#change("(", ")")<CR>
    nn <silent> <Plug>ChangeInsideSquare :<C-U>call bbrackets#change("[", "]")<CR>
    nn <silent> <Plug>ChangeInsideCurly :<C-U>call bbrackets#change("{", "}")<CR>
    nn <silent> <Plug>DeleteInsideRound :<C-U>call bbrackets#delete("(", ")", v:count1)<CR>
    nn <silent> <Plug>DeleteInsideSquare :<C-U>call bbrackets#delete("[", "]", v:count1)<CR>
    nn <silent> <Plug>DeleteInsideCurly :<C-U>call bbrackets#delete("{", "}", v:count1)<CR>
endif

nm ci( <Plug>ChangeInsideRound
nm ci) <Plug>ChangeInsideRound
nm ci[ <Plug>ChangeInsideSquare
nm ci] <Plug>ChangeInsideSquare
nm ci{ <Plug>ChangeInsideCurly
nm ci} <Plug>ChangeInsideCurly

nm di( <Plug>DeleteInsideRound
nm di) <Plug>DeleteInsideRound
nm di[ <Plug>DeleteInsideSquare
nm di] <Plug>DeleteInsideSquare
nm di{ <Plug>DeleteInsideCurly
nm di} <Plug>DeleteInsideCurly

if &mps =~ "<:>" && exists("g:loaded_repeat")
    nn <silent> <Plug>ChangeInsideAngle :<C-U>call bbrackets#change("<", ">") \| call repeat#set("\<Plug>ChangeInsideAngle")<CR>
    nn <silent> <Plug>DeleteInsideAngle :<C-U>call bbrackets#delete("<", ">", v:count1) \| call repeat#set("\<Plug>DeleteInsideAngle")<CR>
elseif &mps =~ "<:>" && !exists("g:loaded_repeat")
    nn <silent> <Plug>ChangeInsideAngle :<C-U>call bbrackets#change("<", ">")<CR>
    nn <silent> <Plug>DeleteInsideAngle :<C-U>call bbrackets#delete("<", ">", v:count1)<CR>
endif

if &mps =~ "<:>"
    nm ci< <Plug>ChangeInsideAngle
    nm ci> <Plug>ChangeInsideAngle

    nm di< <Plug>DeleteInsideAngle
    nm di> <Plug>DeleteInsideAngle
endif
