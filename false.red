; false.red
Red []

s: stack: []

print-stack: does []
; print-stack: does [prin "stack: " print s]
dbg: function[a][]
; dbg: function[a][print a]

pop: does [h: take s]
push: function[a][insert s a]

digit: charset "0123456789"
number: [copy n [some digit] (dbg n insert s load n)]

; +: :add ; creates hell on console
; *: :multiply

; symbol: [copy op ["+" | "*"] (print get-word op insert s add take s take s)]
; "+" "-" "*" "/" "_"
op: [ "+" (push add pop pop)
    | "-" (push subtract pop pop) 
    | "*" (push multiply pop pop) 
    | "/" (push divide pop pop) 
    | "_" (push negate pop) ]

; "="	">"
tf: function[v][either v [-1][0]]

; tf: function[v][ if v[t: -1] if not v[t: 0] t]

bool: [ "=" (push tf equal? pop pop)
      | ">" (push tf greater? pop pop) ]
    

false-lang: [any [[space | number | op | bool] (print-stack)] ]

fac: {[$1=$[\%1\]?~[$1-f;!*]?]f:}
print parse fac false-lang

ex1: "1 2 + 4 *"
print parse ex1 false-lang
; print s/1

; test: does [a][print reduce [parse a false-lang]]
; test "12 + 3"
; print parse "1 1+" false-lang
; print parse "1 21+" false-lang

s: []
print parse "1 2 -" false-lang
; print s/1

s: []
print parse "1 _ " false-lang
; print s/1

s: []
print parse "3 6 / " false-lang
print s/1 = 2


; test: function[f /local s][print parse f false-lang print s]
test: function[f v][clear s print equal? v parse f false-lang]

test "1 1 =" true
test "1 0 <" false

