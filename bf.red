Red[
    ; Code example from Red Programming Language blog "0.4.1: Introducing Parse"
    ; Nenad Rakocevic
    ; http://www.red-lang.org/2013/11/041-introducing-parse.html
    ; "a simple interpreter for a famous obfuscated language, written using Parse" 
]

bf: function [prog [string!]][
    size: 30000
    cells: make string! size
    append/dup cells null size

    parse prog [
        some [
              ">" (cells: next cells)
            | "<" (cells: back cells)
            | "+" (cells/1: cells/1 + 1)
            | "-" (cells/1: cells/1 - 1)
            | "." (prin cells/1)
            | "," (cells/1: first input "")
            | "[" [if (cells/1 = null) thru "]" | none]
            | "]" [
                pos: if (cells/1 <> null)
                (pos: find/reverse pos #"[") :pos
                | none
                ]
            | skip
        ]
    ]
]

; This code will print a Hello World! message
bf {
    ++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.
    >++.<<+++++++++++++++.>.+++.------.--------.>+.>.
}

; This one will print a famous quote
bf {
    ++++++++[>+>++>+++>++++>+++++>++++++>+++++++>++++++++>
    +++++++++>++++++++++>+++++++++++>++++++++++++>++++++++
    +++++>++++++++++++++>+++++++++++++++>++++++++++++++++<
    <<<<<<<<<<<<<<<-]>>>>>>>>>>>----.++++<<<<<<<<<<<>>>>>>>
    >>>>>>.<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<<<<<<<<<<>>
    >>>>>>>>>>>>++.--<<<<<<<<<<<<<<>>>>>>>>>>>>>---.+++<<<<
    <<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>+.-<<<<<<<<<<<<<>>>>>>>>
    >>>>>>+++.---<<<<<<<<<<<<<<>>>>.<<<<>>>>>>>>>>>>>>--.++
    <<<<<<<<<<<<<<>>>>>>>>>>>>>>-.+<<<<<<<<<<<<<<>>>>.<<<<>
    >>>>>>>>>>>>>+++.---<<<<<<<<<<<<<<>>>>>>>>>>>>>>.<<<<<<
    <<<<<<<<>>>>>>>>>>>>>>-.+<<<<<<<<<<<<<<>>>>>>>>>>>>>>-.
    +<<<<<<<<<<<<<<>>>>>>>>>>>>>>--.++<<<<<<<<<<<<<<>>>>+.-
    <<<<.
}

