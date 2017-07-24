<!--; blog.md-->
<!--; was: false.red.md-->
<!--; a catch-all file for meta description, stream of thought-->

# Blog

#### Don't override `+` and other basic symbols
ops: tried to directly override + and *, 
; but that creates hell on console (and crash)
; +: :add ; 
; *: :multiply
; symbol: [copy op ["+" | "*"] (print get-word op insert s add take s take s)]


copy-pasted according to the manual,
most descriptions can be directly convert into rules and text
for example: XXX
(note the reversed stack)

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

