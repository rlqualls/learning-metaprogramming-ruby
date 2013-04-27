#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Ruby includes some methods, like puts, that can be called anywhere
# How is this possible?

#puts "Hello, World" # => nil

# It turns out that puts is a private instance method of the Kernel module

Kernel.private_instance_methods.grep(/^p/) # => [:printf, :print, :putc, :puts, :p, :proc]

# The class Object includes the module Kernel, so Kernel's methods get into
# every object's ancestors chain

Object.private_instance_methods.grep(/^p/) # => [:printf, :print, :putc, :puts, :p, :proc]

# Since Ruby code always exists inside an Object, this can be used to define 
# other methods that can be called like puts

module Kernel
  def hello
    puts "Hello World"
  end
end

# hello # => nil
# >> Hello World
