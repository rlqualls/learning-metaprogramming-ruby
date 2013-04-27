#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Ruby provides the ability to define methods at runtime using define_method

"abc".respond_to?(:multiply) # => false

class String
  define_method(:multiply) do |numtimes|
    self * numtimes
  end
end

"abc".respond_to?(:multiply) # => true
"abc".multiply(4)            # => "abcabcabcabc"

# Although classes can be reopened at runtime as above, there is a more flexible
#  way to use define_method by using "send"
# "define_method" is private, so it cannot be called directly

"abc".respond_to?(:double) # => false

String.send(:define_method, :double) do
  self * 2
end

"abc".respond_to?(:double) # => true
"abc".double # => "abcabc"

# Note: this defines an instance method, not a class method

String.respond_to?(:double) # => false
