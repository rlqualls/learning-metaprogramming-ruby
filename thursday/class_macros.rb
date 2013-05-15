#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Class macros are keyword-looking class methods that are intended to be used
#  inside class definitions
# Some examples of class macros include the family of attr_ methods in Module

Module.private_methods.grep(/^attr_/) # => [:attr_reader, :attr_writer, :attr_accessor]

# attr_accessor can be used to define public object attributes for a class

class AttributesClass
  attr_accessor :x, :y
end

butes = AttributesClass.new # => #<AttributesClass:0x83a7534>
butes.x = 10
butes.y = "blah" + butes.x.to_s

butes.x                     # => 10
butes.y                     # => "blah10"

# Another popular use for class macros is in ActiveRecord
# class user < ActiveRecord::Base
#   has_many :badges
# end
