; false.red
Red []

s: stack: []
pop: does [take s]
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

falsify: function[prog][parse prog false-lang]