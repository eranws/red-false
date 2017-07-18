Red []

banana: "banana" ; string example, can be image or a real banana
                    ; or a function that returns a banana (if remains)
                    ; throws if out of stock 

cut: function[a][   ; this is an action that receives an object and returns it modified
                    ; if input is image it can be cut into two.
    half: (length? a) / 2
    while [(index? a) <= half][a: next a]
    insert a space ; cut!
    head a ; reset, return head
]

chop: function[a][
    h: (length? a) * 2    
    while [(index? a) < h][a: next a insert a space a: next a]
    insert a space ; cut!
    head a ; reset, return head
]

recipe-string: "chop banana"
; recipe-string: "cut banana"
recipe: load recipe-string

rule: [action object description]
action: ['cut | 'mix | 'chop]
object: ['carrot | 'banana]
description: ['in 'two | 'to 'slices | none]

if(parse recipe rule)[
    out: do recipe ; modifies the given state
    print out
]

; as parse expressions, denser and works directly on input
; but not transferrable to other domains

cut-parse: [x: (n: (length? x) / 2) n skip insert space thru end]
b: copy "banana"
parse b cut-parse
print b

chop-parse: [any [x: skip (insert x space) skip]]
b: copy "banana"
parse b chop-parse
print b


; test: 1
if (value? 'test)[
; parse ["cut banana"] rule ; string based
; parse load do ["cut banana"] rule ; symbol based
print parse load "cut banana" rule ; same
print parse load "cut banana in two" rule
print parse load "cut banana to slices" rule
; print parse-trace load "cut 2 banana to slices" rule
; quantity: [1 1 integer? | none (q: 1)]
]
