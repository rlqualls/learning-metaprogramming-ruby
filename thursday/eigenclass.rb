#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# In Ruby it is possible to attach methods to a single object

obj = Object.new
def obj.hello
  "hello world"
end
obj.hello                          # => "hello world"
obj.singleton_methods              # => [:hello]

# But in Ruby, methods live in classes, so how is this possible?
# It turns out that each object in Ruby ships with a hidden class
# This is called its singleton class, or eigenclass
# The German "eigen" tends to translate to "own" or "proper"
# Think of an eigenclass as "an object's own class"
# 
# Ruby has a special "class <<" syntax we can use to change "self"
# to the eigenclass
#
# class << object_in_question
#   # this code is within the context of the eigenclass
# end

eigen = class << obj
  self
end

eigen            # => #<Class:#<Object:0x9c960e0>>
eigen.class      # => Class
eigen.superclass # => Object

# As shown here, eigen is a Class object and not just an Object
# 
# But wait - if objects have eigenclasses, and eigenclasses are objects, 
# then do eigenclass objects have eigenclasses?

eigen_eigen = class << eigen
  self
end

eigen_eigen            # => #<Class:#<Class:#<Object:0x9c960e0>>>
eigen_eigen.class      # => Class
eigen_eigen.superclass # => #<Class:Object>

# They do!
# 
# Let's prove that a singleton method, or eigenmethod, is nothing more
# than a method defined on an eigenclass

class << obj
  def bye
    "goodbye"
  end
end

obj.bye               # => "goodbye"
obj.singleton_methods # => [:hello, :bye]

# The real usefulness of eigenclasses comes from the ability to define
# singleton methods on Class objects to get class methods

class << String
  def generate
    ('a'..'z').to_a.shuffle[0, 8].join # stackoverflow 88311
  end
end

String.generate # => "bhmviuzq"
String.generate # => "ilhxqcnr"

# It's easy to define a method that return an object's eigenclass instead of
# relying on the verbose syntax used so far

class Object
  def eigenclass
    class << self; self; end
  end
end 

"random string".eigenclass # => #<Class:#<String:0x9c94560>>
