; false.red
Red []

s: stack: []

debug-print: does []
debug-prin: does []

; debug-print: :print
; debug-prin: :prin

; print-stack: does [debug-print]
; print-read: does []
print-stack: does [debug-prin " stack: " debug-print s]
print-read: function[a][debug-prin " read: " debug-print a]

pop: does [h: take s]
push: function[a][insert s a]

digit: charset "0123456789"
number: [copy n [some digit] (push load n)]

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
tf: function[v][either ((v = true) or (v = -1)) [-1][0]]

; bool: [ "=" (t: equal? pop pop push (tf t))
bool: [ "=" (push tf equal? pop pop)
      | ">" (push tf (lesser? pop pop))
      | "~" (push tf (complement pop))
      | "&" (push tf (and~ pop pop)) 
      | "|" (push tf (or~ pop pop)) ]

value: ["'" set val skip (push to-integer val)]

lower: charset [#"a" - #"z"]
variable: [ copy var lower [ 
            ":" (set load var pop) (debug-prin " set: " debug-print var) | 
            ";" (push get load var) (debug-prin " get: " debug-print var)
            ]]

; TODO: parse funcion inside function 

; lamb-sep: charset "[]"
not-sep: complement charset "[]"

escaped: [expr | some [not ["[" | "]"]] skip ]
expr: [ "[" escaped "]" ]

lambda: [ "[" copy f any expr "]" (push f)] ; push the expression as-is to the stack
apply: [ "!" (debug-print "apply") (f: pop parse f false-lang)]  ; execute from the head as if it was read from original string

stack-functions: [ "$" (push pick s 1)      
                 | "%" (pop)                 
                 | "\" (swap s next s)       
                 | "@" (swap s next s swap s next next s)
                 | "ø" (push pick s 1 + pop) ]

if?: [ "?" (f: pop if (pop = tf true) [parse f false-lang])]

while?: ["#" (
        body: pop
        cond: pop
        debug-prin { body: } debug-print body
        debug-prin { cond: } debug-print cond
        while [
            (parse cond false-lang) ; run function
            p: pop
            debug-prin { p: } debug-print p
            p = (tf true)] [parse body false-lang])]

false-lang: [any [ 
                copy sym
                [space | number | op | bool | value | variable | 
                lambda | apply | stack-functions | if? | while? ] 
                (print-read sym)
                (print-stack)] ]

; XXX throws error since if? added
; fac: {[$1=$[\%1\]?~[$1-f;!*]?]f:}
; print parse fac false-lang

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

test: function[f v][
    clear s 
    p: parse f false-lang 
    result: equal? v s/1
    print result
    if (p = false) [
        print ["FAIL:" f]
        ; parse-trace f false-lang 
        ]
    ; prin { f: "} prin f print {"}
    ; prin { v: "} prin v print {"}
    ; prin { s/1: "} prin s/1 print {"}
    ; prin { equal? "} prin result print {"}
    ; prin newline
    ]

test-stack: function[f st][
    clear s 
    p: parse f false-lang 
    result: equal? st s
    print result

    ; prin { f: "} prin f print {"}
    ; prin { st: "} prin st print {"}
    ; prin { s: "} prin s print {"}
    ; prin { equal? "} prin result print {"}
    ; prin newline
    ]

test-print: function[f st][
    clear s 
    p: parse f false-lang 
    result: equal? st s/1
    print result

    prin { parse: "} prin p print {"}
    prin { f: "} prin f print {"}
    prin { st: "} prin st print {"}
    prin { s: "} prin s print {"}
    prin { equal? "} prin result print {"}
    prin newline
    ]

test-trace: function[f st][
    clear s 
    p: parse-trace f false-lang 
    result: equal? st s
    print result
]

; eq, greater
test "1 1 =" -1
test "1 0 >" -1

; ; not
test "1 0 =~" -1
test "1 0 = ~" -1

test "1 2 >" 0
test "1 2 > ~" -1

test "1 1 =~" 0

test "1 1 = 1 0 = |" -1

test "0  0  |" 0
test "1_ 0  |" -1
test "0  1_ |" -1
test "1_ 1_ |" -1

test "0  0  &" 0
test "1_ 0  &" 0
test "0  1_ &" 0
test "1_ 1_ &" -1

test "1_ ~" 0
test "0  ~" -1

test "'A" 65
test "' " 32
; test "1a:"      ; { a:=1 }
; test "a;1+b:"   ; { b:=a+1 }
test "1a:a;1+b:b;" 2
test "2[1+]!" 3

; [1+]i:
; 2i;!

test "[1+]i:2i;!" 3

test-stack "1$" [1 1]
test-stack "1 2%" [1]
test-stack "1 2\" [1 2]
test-stack "1 2 3" [3 2 1]
test-stack "1 2 3@" [1 3 2]
test-stack "7 8 9 2ø" [7 9 8 7]

test "1_[3]?" 3
test "0[3]?" none
test "0~[3]?" 3
test "1_~[3]?" none
test "1 1=$[]?~[4]?" none

; a;1=["hello!"]?		{ if a=1 then print "hello!" }
; no strings yet!

; test "[1_][]#" error? ;infinite-loop
; [a;1=][2f;!]#		{ while a=1 do f(2) } ; will never stop
test "[0][]#" none
test "0b:5a:[0a;=~][1a;-a:b;1+b:]#b;" 5
test "15a:[a;0>][6a;-a:]#a;" -3; f: function[a: a - 6] { while a > 0 do f() }

test "0b:5a:[0a;=~][1a;-a:b;1+b:]#b;" 5
test "111 3a:[0a:]x:x;!a;" 0

test "[[123]]x:x;" "[123]"
test "[[]]x:x;" "[]"

test "[[][]]x:x;" "[][]"
test "[1]" "1"
test "[][]" ""
test "[[]]" "[]"

; test-print "123 3a:[0a:]x:[0a=~][x;!]#a;" 0 ; BUG BUG function call inside while does not work :~|
; test "10 []x:x;" [10]
; test-stack "11 [[]]x:x;" [[] 11]
; test "144 [[]]x:x;" [123]
; test "144 [[]]x:x;" [123]
; test-print "155 [[][]]x:x;" [123]
