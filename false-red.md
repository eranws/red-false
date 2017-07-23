; false.red.md

--- questions:
why false? 
why forth? 

; what is this stack (runtime? or compiler. can run interpreted?)


## what is the usage of such language?
eduactional mostly, 
even the seasoned programmer is mostly developing at the variables and function. as a user
manipulaing symbols and 

false is a gradually built language, 
if you are aware of the concept of calculator then you are 
already a programmer at level two.

evaluation
elementary functions
values
global variables
lambda functions
stack functions
control structure
Input/Output

## Implementation
false interpreter is built using Red language parsing engine, and a series as a stack
since most symbols are one character, and result in operation on the stack

## Red specific
all symbols are global, so 

f: "1+" ; red-code
floss: function[fl][parse fl false-lang] ; interpreter
floss "1f;!" ; 


# Ideas
* add operators, functions, or closures?

# Blog

copy-pasted according to the manual,
most descriptions can be directly convert into trules and text

for example: XXX

ops: tried to directly override + and *, 
; +: :add ; 
; *: :multiply
; but that creates hell on console (and crash)
; symbol: [copy op ["+" | "*"] (print get-word op insert s add take s take s)]


lambda functions was tricky, but now I finally understood it

standard input output is modelled with red strings


; sunday 1am, not sure how to set io like getchar, can't compile using ask/input
; using red strings as mocks, set beforehand for testing, or read from preset file
; if string is empty, return -1 (eof)
; in-file: %false-in
; out-file: %false-out
; flush can: 
;  - write/append out-file data
;  - print data

; cool idea: make i and o symbols to access io buffers within false ?!

; eval function
; false-eval: function[expr][parse expr false-lang]
; false-eval {ß"hi"}
