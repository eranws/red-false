# red-false

this is a compiler for [FALSE] language written in [Red]
(in less than 50 lines of code) 

in the `src/` directory you will find:
* [false.red](false.red) - the implementation written in Red
* [false.txt](false.txt) - the original document
* [false-args.red](false-args.red) - example how to run false programs from command-line
* [false-factorial.red](false-factorial.red) - compute the factorial function (and inter-op tricks)
* [false-test.red](false-test.red) - tests written along the way

## why?

I've recently learned this new language called *Red* and I was looking for a good enough use-case to use it. As the FALSE language might not be practical for everyday use, I have found this journey in the work of esoteric languages interesting and educational.

Even for the seasoned programmer, most of development is done using *some* language, at the level of variables and functions, mostly writing procedures, classes and interfaces.

Writing a compiler to understand language - is quite mind boggling; rarely you will need to know *how* functions work, or need to define the control-flow *itself*.

## tutorial
I am working on a mini tutorial to show how FALSE can be built starting from the concept of calculator, simply adding numbers - and extending it with *words* - variables and functions, up to a full blown compiler.

[Red]: http://www.red-lang.org/p/about.html
[FALSE]: http://strlen.com/false-language/
