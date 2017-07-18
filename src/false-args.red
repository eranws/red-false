Red[]
#include %false.red

args: system/options/args

either args/1 [
    prin "input: " print args/1
    parse args/1 false-lang
    prin "output: " print out-buffer
][
    print "USAGE:"
    print "(interpreted)"
    print [tab {red false-args.red <expr>}]
    print "(compiled)"
    print [tab "red -c false-args.red"]
    print [tab "./false-args <prog>"]
    print "EXAMPLE:"
    print "this should print 9 to stdout"
    print [tab {./false-args "3 3*."}]
]
