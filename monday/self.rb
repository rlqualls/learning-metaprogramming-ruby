#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Every line of Ruby code is run inside of an object called the current object
# The current object can be accessed with the "self" method

self                     # => main
self.class               # => Object

# Ruby automatically creates an object called the top-level context 
# The top-level context is the object that code is in when at the top of the
#  call-stack: where no methods have been executed, or all have returned

class MyClass
  def what_is_self
    self                 # => #<MyClass:0x991dff8>
  end
end

self                     # => main
MyClass.new.what_is_self # => #<MyClass:0x991dff8>

# Since self can be called outside of a method, this is also possible

class SelfClass
  self                   # => SelfClass
end
