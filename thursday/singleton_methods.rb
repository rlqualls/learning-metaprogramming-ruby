#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Singleton Methods:
#
# It's possible for individual objects to have their own methods that other
#  objects in the same class do not share: singleton methods
# The singleton method definition pattern looks like this:
# 
# def object.method
#   # method body
# end

normal_str = "123"
enhanced_str = "abc"
def enhanced_str.upall
  upcase
end

# Now enhanced_str has the instance method "upall" but other strings do not

normal_str.methods.grep(/^up/)      # => [:upto, :upcase, :upcase!]
enhanced_str.methods.grep(/^up/)    # => [:upall, :upto, :upcase, :upcase!]
enhanced_str.upall                  # => "ABC"

# Also, even though methods live in classes, upall is not in String's methods

String.instance_methods.grep(/^up/) # => [:upto, :upcase, :upcase!]

# How is this possible? What class does upall belong to?
# It turns out that enhanced_str has a hidden "eigenclass", where upall is stored

eigen = class << enhanced_str
  self
end

eigen                               # => #<Class:#<String:0x8738838>>
eigen.class                         # => Class
eigen.superclass                    # => String
eigen.instance_methods.grep(/^up/)  # => [:upall, :upto, :upcase, :upcase!]

# See eigenclasses.rb for more information about eigenclasses

# Class Methods:
#
# A class method is actually just a singleton method defined on a class 
# Compare:

# singleton method on an object of class string:

str = String.new
def str.random(size)
  array = size.times.map { Random.rand(9).to_s }
  array.join
end

str.random(5)    # => "66725"

# singleton method on an object of class Class:

def String.random(size)
  array = size.times.map { Random.rand(9).to_s  }
  array.join
end

String.random(5) # => "25057"
