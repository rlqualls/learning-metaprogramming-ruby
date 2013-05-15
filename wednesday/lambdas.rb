#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# A lamda is a callable object in Ruby
# Underneath the hood, it is really just a special proc

lam = lambda { "I am a lambda" } # => #<Proc:0x8839a70@-:7 (lambda)>
lam.class                        # => Proc
lam.call                         # => "I am a lambda"

# Unlike Proc, there is no Lambda class in Ruby

defined? Proc   # => "constant"
defined? Lambda # => nil

# Since Ruby 1.9, lambdas can be defined via "stabby-lambda" syntax
# It makes it possible to define a lambda with "obj = ->(*args) { block }"

stab_lambda = ->(x, y) { x + y }               # => #<Proc:0x8839174@-:19 (lambda)>
regu_lambda = lambda { |x, y| x + y }          # => #<Proc:0x8838fbc@-:20 (lambda)>
stab_lambda.class == regu_lambda.class         # => true
stab_lambda.call(2,3) == regu_lambda.call(2,3) # => true

# Two things separate lambdas from procs and blocks
#  - return keyword returns from lambda, not scope where the lambda was defined
#  - the arity is checked

# With a proc, the "return" keyword returns from the scope where the proc was defined
# This can lead to unreachable code or code that tries to return from the top-level

def proc_demo_return
  p = Proc.new { return "reachable code from proc" }
  p.call
  return "unreachable code AFTER proc call!"
end

proc_demo_return   # => "reachable code from proc"

# This problem does not occur with lambdas

def lambda_demo_return
  p = lambda { return "reachable code from lambda" }
  p.call
  return "reachable code AFTER lambda call"
end

lambda_demo_return # => "reachable code AFTER lambda call"

# Also, unlike procs, lambdas check the number of arguments passed into them

def lambda_argument_test(*args)
  begin
    p = ->(x, y) { x + y }
    p.call(*args)
  rescue ArgumentError 
    "Wrong number of arguments"
  end
end

lambda_argument_test(4,5)   # => 9
lambda_argument_test(4,5,6) # => "Wrong number of arguments"
lambda_argument_test(4)     # => "Wrong number of arguments"
