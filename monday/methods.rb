#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# In Ruby, methods live in classes
# All instance methods can be retrieved with the method "instance_methods"
# All methods, including instance methods, can be retrieved with the method "methods"

Object.instance_methods[1..10] # => [:===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup]
Object.methods[1..10]          # => [:new, :superclass, :freeze, :===, :==, :<=>, :<, :<=, :>, :>=]

# It is important not to confuse "instance_methods" with "methods" in class vs instance 
# When "methods" is called against an instance, it returns the instance methods

String.methods[1..10]          # => [:allocate, :new, :superclass, :freeze, :===, :==, :<=>, :<, :<=, :>]
String.instance_methods[1..10] # => [:==, :===, :eql?, :hash, :casecmp, :+, :*, :%, :[], :[]=]
"abc".methods[1..10]           # => [:==, :===, :eql?, :hash, :casecmp, :+, :*, :%, :[], :[]=]

# The receiver of a method is always whatever is currently self

def add(x, y)
  self   # => main
  x + y
end

self     # => main
add(2,3) # => 5
