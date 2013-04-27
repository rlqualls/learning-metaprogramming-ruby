#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# In Ruby, classes are nothing but objects, instances of class Class

"hello".class                            # => String
String.class                             # => Class
Class.class                              # => Class

# Since Class is an object, it has instance_methods
# False here is passed in to ignore inherited instance methods

Class.instance_methods(false)            # => [:allocate, :new, :superclass]

# One of the instance methods returned was superclass, which returns the parent in the class hierarchy

Class.superclass                         # => Module
Module.superclass                        # => Object
Object.superclass                        # => BasicObject
BasicObject.superclass                   # => nil

String.superclass                        # => Object
Array.superclass                         # => Object

# It is also possible to get a class's entire ancestors chain

String.ancestors                         # => [String, Comparable, Object, Kernel, BasicObject]
Integer.ancestors                        # => [Integer, Numeric, Comparable, Object, Kernel, BasicObject]
