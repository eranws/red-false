; false.red
Red []

s: stack: []
pop: does [h: take s]
push: function[a][insert s a]

digit: charset "0123456789"
number: [copy n [some digit] (push load n)]

; basic operations
op: [ "+" (push add pop pop)
    | "-" (push subtract pop pop) 
    | "*" (push multiply pop pop) 
    | "/" (push divide pop pop) 
    | "_" (push negate pop) ]

; helper, convert truthvalue to 0, -1
tf: function[v][either ((v = true) or (v = -1)) [-1][0]]

bool: [ "=" (push tf equal? pop pop)
      | ">" (push tf (lesser? pop pop))
      | "~" (push tf (complement pop))
      | "&" (push tf (and~ pop pop)) 
      | "|" (push tf (or~ pop pop)) ]

value: [ "'" set val skip (push to-integer val)]

lower: charset [#"a" - #"z"]
variable: [ copy var lower [ 
            ":" (set load var pop) |
            ";" (push get load var)
            ]]

expr: [(dep: 1) any [
    ahead "]" (dep: dep - 1) if (dep = 0) break 
    | "[" (dep: dep + 1)
    | skip ]]

lambda: [ "[" copy fun expr "]" (push fun)] ; push the expression as-is to the stack

; execute from the head as if it was read from original string
apply: [ "!" (fun: pop parse fun false-lang)] 

stack-functions: [ "$" (push pick s 1)      
                 | "%" (pop)                 
                 | "\" (swap s next s)       
                 | "@" (swap s next s swap s next next s)
                 | "ø" (push pick s 1 + pop) ]

if?: [ "?" (fun: pop if (pop = tf true) [parse fun false-lang])]

while?: ["#" (body: pop cond: pop 
        while [
        (parse cond false-lang) ; run function
        pop = (tf true) ][parse body false-lang])]

in-buffer: ""
out-buffer: ""
string: [ {"} copy str to {"} skip (append out-buffer str)] ; todo: esacpe "
std-out: [ "." (append out-buffer pop) | "," (append out-buffer to-char pop)]
std-in: ["^^" (caret: take in-buffer push either (caret = none)[-1][caret])] 
flush: ["ß" (clear out-buffer clear in-buffer)]

false-lang: [ any [ 
    space | number | op | bool | value | variable | 
    lambda | apply | stack-functions | if? | while? |
    string | std-out | std-in | flush ]]

; --- tests
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

test: function[ex v][
    clear s 
    p: parse ex false-lang 
    result: equal? v s/1
    print result
    if (p = false) [
        print ["FAIL:" ex]
        ; parse-trace f false-lang 
        ]
    ; prin { ex: "} prin ex print {"}
    ; prin { v: "} prin v print {"}
    ; prin { s/1: "} prin s/1 print {"}
    ; prin { equal? "} prin result print {"}
    ; prin newline
]

test-stack: function[ex st][
    clear s 
    p: parse ex false-lang 
    result: equal? st s
    print result

    ; prin { ex: "} prin ex print {"}
    ; prin { st: "} prin st print {"}
    ; prin { s: "} prin s print {"}
    ; prin { equal? "} prin result print {"}
    ; prin newline
]

test-print: function[ex st][
    clear s 
    p: parse ex false-lang 
    result: equal? st s/1
    print result

    prin { parse: "} prin p print {"}
    prin { ex: "} prin ex print {"}
    prin { st: "} prin st print {"}
    prin { s: "} prin s print {"}
    prin { equal? "} prin result print {"}
    prin newline
]

test-trace: function[ex st][
    clear s 
    p: parse-trace ex false-lang 
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

; or, and

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

; values (ASCII)
test "'A" 65
test "' " 32

; variables
; test "1a:"      ; { a:=1 }
; test "a;1+b:"   ; { b:=a+1 }
test "1a:a;1+b:b;" 2

; functions
test "2[1+]!" 3

; [1+]i:
; 2i;!

test "[1+]i:2i;!" 3

; stack functions
test-stack "1$" [1 1]
test-stack "1 2%" [1]
test-stack "1 2\" [1 2]
test-stack "1 2 3" [3 2 1]
test-stack "1 2 3@" [1 3 2]
test-stack "7 8 9 2ø" [7 9 8 7]

; control-flow if
test "1_[3]?" 3
test "0[3]?" none
test "0~[3]?" 3
test "1_~[3]?" none
test "1 1=$[]?~[4]?" none

; a;1=["hello!"]?		{ if a=1 then print "hello!" }
; no strings yet!

; control-flow while

; test "[1_][]#" error? ;infinite-loop
; [a;1=][2f;!]#		{ while a=1 do f(2) } ; will never stop
test "[0][]#" none
test "0b:5a:[0a;=~][1a;-a:b;1+b:]#b;" 5
test "15a:[a;0>][6a;-a:]#a;" -3; f: function[a: a - 6] { while a > 0 do f() }

test "0b:5a:[0a;=~][1a;-a:b;1+b:]#b;" 5
test-stack "5a:[0a;=~][1a;-a:8]#" [8 8 8 8 8]
test "111 3a:[0a:]x:x;!a;" 0

test "[[123]]x:x;" "[123]"
test "[[]]x:x;" "[]"

test "[[][]]x:x;" "[][]"
test "[1]" "1"
test "[][]" ""
test "[[]]" "[]"

test-stack "112 [[]]x:x;" ["[]" 112]
test-stack "113 [[][]]x:x;" ["[][]" 113]
test-stack "10 []x:x;" ["" 10]

test "123 3a:[0a:]x:[0a;=~][0a:]#a;" 0

test {ß} none
print in-buffer = ""
print out-buffer = ""

test "123.%" none ;	{ prints string "123" on console }
print out-buffer = "123"

test {ß} none
test "65,%" none  ;	{ prints "A" }
print out-buffer = "A"

test {ß} none
test {"bye"1} 1 ; prints hi
print out-buffer = "bye"

; tests string escape
; test-out {"g^"r"} {g"r}
; test {"hel%lo"ß1} 1 

in-buffer: "QWEQWE"
out-buffer: ""
test {"bla"^^.^^.} none
print equal? in-buffer "EQWE"
print equal? out-buffer "blaQW"

test {ß} none

in-buffer: "QWERTY"
test {[^^$1_=~][,]#} -1 ; reads in and writes to out
out-buffer = "QWERTY"

fac: {[$1=$[\%1\]?~[$1\-f;!*]?]f:6f;!}
test fac 720
