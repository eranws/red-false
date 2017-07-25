Red []
; 01-evaluation.red

; stack crash course or refresher
s: stack: []
pop: does [take s]
push: function[a][insert s a]

push 1
push 2
print pop
print pop
; first 2 then 1

digit: charset "0123456789"
number: [copy n [some digit] (push load n)]
false-lang: [ any [ space | number ] ]

ex1: "1 2 + 4 *"
print parse ex1 false-lang
; print s/1
