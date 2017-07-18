Red[]
#include %false.red

falsify {[$1=$[\%1\]?~[$1\-f;!*]?]f:}   ; load factorial into f
falsify {6}                             ; insert 6 to stack
falsify {f;!}                           ; apply factorial to 6
falsify {.}                             ; print result to out-buffer
print out-buffer

; inter-operablity 1: define false function in red
g: "1 1+" 
falsify {ß} ; clean buffer
falsify {g;!} ; apply g
falsify {.}     ; read result
print out-buffer

; inter-operablity 2: define red function (string) from false
falsify {ß} ; clean buffer
falsify {[function [a b][a ** b]]p:} ; define p for power
pow: do p ; load function string
print pow 3 4 ; in red
; for now, it can only pass strings, and use `do` from red
; it is simple to add rule to run red from within false
; using backtick (`)
