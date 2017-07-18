Red []

banana: "banana" ; string example, can be image or a real banana

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
