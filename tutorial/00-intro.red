Red []

msg: "hello world"
print msg 

digit: "1" ; charset "0123456789"
; number: [] (TODO)
token: [digit | space]
false-lang: [ any token ]

example: " 1 11 1  1" ; example expression

result: parse ex0 false-lang
print either (result) ["success"]["fail"]

; exrecise 0
; extend token to include number

; | (choice) has priority - should be before or after digit
; is digit necessary?

; hint: use `some` keyword
; link to reference
