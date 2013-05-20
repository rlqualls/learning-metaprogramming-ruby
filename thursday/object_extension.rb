#!/usr/bin/env ruby 
# Copyright Robert Qualls 2013

# Although it seems logical, it is not possible to include class methods from
#  a module directly

module BadAddModule
  def self.add(a, b)
    a + b
  end   
end

class BadMathClass
  include BadAddModule
end

result = begin 
           BadMathClass.add(2, 3) 
         rescue NoMethodError 
           "No Method" 
         end

BadMathClass.singleton_methods # => []
result                         # => "No Method"

# The class is still math illiterate because 
# "when a class includes a module, it gets the module's instance methods - not 
#  the class methods" - Metaprogramming Ruby, section 4.5 (Module Trouble)

# This can be fixed by including module instance methods in the eigenclass 
# That way, the module's instance methods become singleton methods of the class

module GoodAddModule
  def add(a, b)
    a + b
  end
end


class GoodMathClass
  class << self
    include GoodAddModule
  end 
end

GoodMathClass.singleton_methods # => [:add]
GoodMathClass.add(2, 3)         # => 5

# Now, add is an instance method of the eigenclass of GoodMathClass 

# So far, that is a rather verbose way to get class methods from a module
# Fortunately, this is where object extension comes in
# Since class methods are just a case of singleton methods, this trick can
#  apply to any object

obj = Object.new
class << obj
  include GoodAddModule
end

obj.singleton_methods         # => [:add]
obj.add(1,2)                  # => 3

# This is called object extension, and there is a shortcut for it in Ruby
# Object#extend

obj2 = Object.new
obj2.extend GoodAddModule
obj2.add(3, 3)                # => 6

# extend can be used in class definitions as well...

class AnotherMathClass
  extend GoodAddModule
end

AnotherMathClass.add(4, 5)    # => 9

# ...or instances of Class

YetAnotherMathClass = Class.new
YetAnotherMathClass.extend GoodAddModule
YetAnotherMathClass.add(2, 2) # => 4
