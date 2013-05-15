#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# A proc is one of several callable objects available to Ruby
# A proc can be created via the Proc class constructor
# The constructor must be passed a block

pr = Proc.new { "I am a proc" } # => #<Proc:0x949d104@-:8>
pr.call                         # => "I am a proc"

# The Kernel module also provides a proc method which receives a block
#  and returns a proc object

Kernel.methods.grep(/^proc/)    # => [:proc]

kernel_pr = proc { "I am a kernel-created proc" } # => #<Proc:0x9340694@-:16>
kernel_pr.call                                    # => "I am a kernel-created proc"

# The & operator can convert a block into a proc
# The & operator is only expected at the last argument of a method, if at all 

def block_to_proc(arg_x, arg_y, &block)
  block
end

obj = block_to_proc("blarg", [1,34]) { "This block will be converted to a proc object" }
obj.class # => Proc
obj.call  # => "This block will be converted to a proc object"

# Returning "&block" instead of "block" will result in an "unexpected ampersand" error
# This is because a block is not a Ruby object, even though it is a callable 
#  construct that can be passed around

# Procs do not strictly check their arity
# Extra arguments to their blocks are thrown away
# Missing arguments to their blocks are set to nil

arg_proc = proc { |x, y, z| [x, y] }
arg_proc.call(1,2,3,4) # => [1, 2]
arg_proc.call(1,2,3)   # => [1, 2]
arg_proc.call(1,2)     # => [1, 2]
arg_proc.call(1)       # => [1, nil]

# If the number of arguments are required to match, a lambda or method is more
#  reliable
