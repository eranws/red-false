; false.red
Red []

s: stack: []
print-stack: does [prin "stack: " print s]
pop: does [h: take s]

digit: charset "0123456789"
number: [copy n [some digit] (print n insert s load n)]

; +: :add ; creates hell on console
; *: :multiply

; symbol: [copy op ["+" | "*"] (print get-word op insert s add take s take s)]
; "+" "-" "*" "/" "_"
op: [ "+" (insert s add pop pop)
    | "-" (insert s subtract pop pop) 
    | "*" (insert s multiply pop pop) 
    | "/" (insert s divide pop pop) 
    | "_" (insert s negate pop) ]

; "="	">"
bool: [ "=" (insert s equal? pop pop)
      | ">" (insert s greater? pop pop) ]
    

false-lang: [any [[space | number | op | bool] (print-stack)] ]

fac: {[$1=$[\%1\]?~[$1-f;!*]?]f:}
print parse fac false-lang

ex1: "1 2 + 4 *"
print parse ex1 false-lang
print s/1

; test: does [a][print reduce [parse a false-lang]]
; test "12 + 3"
; print parse "1 1+" false-lang
; print parse "1 21+" false-lang
s: []
print parse "1 2 -" false-lang
print s/1

s: []
print parse "1 _ " false-lang
print s/1

s: []
print parse "3 6 / " false-lang
print s/1 = 2


; test: function[f /local s][print parse f false-lang print s]
test: function[f v][clear s print equal? v parse f false-lang]

test "1 1 =" true
test "1 0 <" false

