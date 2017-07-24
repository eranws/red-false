<!--00-intro-->

setup red

let us analyze our components, we have input, processing, memory, and output

input
processing
memory
output

example 0.1
count 1's

example 0.2
mixing ingredients

> Example 0: 
```R
total: 0
digit: "1"
counter: [digit (total: total + 1) | space ] 
parse "1 1 1" []
```

### red reference manual
<!--Red crash course-->

Red is a powerful next-generation language, which this tutorial will 
be written using only a small subset of about 20 functions.

to keep the tutorial self-contained and help the reader,
we'll refer to this tiny, but complete reference manual:


* symbols
* series
* `parse` - we will write the **Rules** in a high level dialect called `parse`, allow to express rules in a very straight forward way.


### symbols
- `load` turns a string `"123"` or `"a"` into a symbol (number, or word `a`). can be replaced with `to-integer` `to-word`
- `set`
- `get`
- `to-integer`
- `to-char`
- `to-word`

### series
- `append`
- `clear`
- `pick`
- `next`
- `insert`
- `take`

### parse

#### keywords
- `any` rule (kleen star)
- `skip`
- `|` (prioritized choice)
- `copy` rule
- `break`
- (Red expression)
- `if` (Red expression) rule


#### elementary operations

#### algebra and logic
add, multiply, negate, equals?, etc. can be taken literally 
as atomic operations given by the hardware.

#### control-flow
- `if`
- `either`
- `while`

### helper functions

does
function

global stack `s`:
- push a (insert s a)
- pop (take s)


