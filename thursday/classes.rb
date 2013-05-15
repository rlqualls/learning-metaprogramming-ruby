#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Classes in Ruby are not merely containers for methods but are runnable code

result = class MyClass
  "value returned from class"
end

result # => "value returned from class"

# Since classes are instances of class Class, they can have instance variables

class InstanceDemo
  @var = 1 

  def self.get_var
    @var
  end
end

InstanceDemo.get_var # => 1

# Class instance variables are in separate scope than object instance variables

class ScopeDemo 
  @var = 1

  def self.get_var
    @var
  end

  def set_var(var)
    @var = var
  end

  def get_var
    @var
  end
end

obj = ScopeDemo.new
obj.set_var("not 1")
obj.get_var       # => "not 1"
ScopeDemo.get_var # => 1

# It is also possible to create class variables using @@ instead of @

class ClassVariableDemo
  @@class_var = "class var"

  def self.set_class_var(value)
    @@class_var = value
  end 

  def self.get_class_var
    @@class_var
  end
end

ClassVariableDemo.get_class_var # => "class var"
ClassVariableDemo.set_class_var "another value"
ClassVariableDemo.get_class_var # => "another value"
