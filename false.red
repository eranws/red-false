; false.red
Red []

false-lang: []


fac: {[$1=$[\%1\]?~[$1-f;!*]?]f:}
print parse fac false-lang

ex1: "1 2 + 4 *"
print parse ex1 false-lang
