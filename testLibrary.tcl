#!/bin/sh
# the next line restarts using tclsh \
    exec tclsh "$0" ${1+"$@"}
#    20080627_000000
load libGetiptcl.so

puts [getip]
puts [getip google.com]
puts [getip non-exist]
puts [getip localhost google.com]
puts [getip badhost sss localhost google.com]
