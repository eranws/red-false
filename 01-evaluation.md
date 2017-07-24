# evaluation

## Implementation
false interpreter is built using Red language parsing engine, and a series as a stack
since most symbols are one character, and result in operation on the stack

---

All elements in the language are defined by what they push on and/or
pop from the stack. 

for example, a number like "1" or "100" simply
pushes it's own value on the stack. An operator like "+" takes the
two top elements of the stack, adds them, and pushes back the result:

1 2 + 4 *	{ (1+2)*4 }

the result of this expression is "12". We will use the notation
(<pops>-<pushes>) to signify what a function does, so "1" does (-num)
and "+" does (n1,n2-result)

complex expressions will keep lots of intermediate results on the stack,
so mostly there's no need for local variables. FALSE doesn't even
have expressions or statements; more likely a program is one stream
of symbols that  manipulate the stack. It's very helpfull when you
can imagine what the stack looks like in a particular part of the program
when programming.