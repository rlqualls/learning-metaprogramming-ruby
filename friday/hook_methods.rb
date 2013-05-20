#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Some Ruby methods are called after a particular message is sent
# These hook methods can be used to respond to programming events

# For example: singleton_method_added

class EventedClass
  attr_reader :singleton_method_list
  
  def initialize
    @singleton_method_list = []
  end

  def singleton_method_added(m)
    @singleton_method_list << m
  end
end

obj = EventedClass.new
obj.singleton_method_list # => []
def obj.hello
  "hello"
end
obj.singleton_method_list # => [:hello]

# Notice that singleton_added was an instance method
# It will also work as a class method 

class EventedClass
  @@num_class_methods = 0

  def self.singleton_method_added(m)
    @@num_class_methods += 1
  end

  def self.num_class_methods
    @@num_class_methods
  end
end

EventedClass.num_class_methods # => 2
def EventedClass.hello
  "Hello"
end
EventedClass.num_class_methods # => 3

# Note that using class variables as above is frowned-upon in Ruby

# Other hook methods include: (reference: stackoverflow.com/questions/5127819)
# 
# method hooks:
#
# method_missing
# method_added
# singleton_method_added
# method_removed
# singleton_method_removed
# method_undefined
# singleton_method_undefined
#
# module hooks:
#
# inherited
# append_features
# included
# extend_object
# extended
# initialize_copy
# const_missing
#
# marshalling hooks:
#
# marshal_dump
# marshal_load
#
# coercion hooks:
#
# coerce
# induced_from
# to_xxx
