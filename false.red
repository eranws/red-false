; false.red
Red []

digit: charset "0123456789"
symbol: ["+" | "*"]
false-lang: [any [digit | space | symbol]]

fac: {[$1=$[\%1\]?~[$1-f;!*]?]f:}
print parse fac false-lang

ex1: "1 2 + 4 *"
print parse-trace ex1 false-lang
