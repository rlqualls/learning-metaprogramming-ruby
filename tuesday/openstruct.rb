#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# It is possible to get javascript-like property assignment in Ruby
# Ruby ships with a class called OpenStruct that can do this

require 'ostruct'

user = OpenStruct.new
user.name = "John Smith"
user.age = 30

user # => #<OpenStruct name="John Smith", age=30>

# Actually, this isn't that much like javascript
# OpenStruct does not include []= assigment. user['age'] = 30 will raise an error
# Fortunately, this is easy to fix using "method_missing" and the bracket operators

class AnyStruct
  
  def initialize
    @properties = {}
  end
  
  def []= (property, value)
    @properties[property] = value
  end

  def [] (property)
    @properties[property]
  end

  def method_missing(method, *args)
    property = method.to_s
    if property =~ /=$/
      @properties[property.chop] = args[0]
    else
      @properties[property]
    end
  end
end

any = AnyStruct.new # => #<AnyStruct:0x8c8429c @properties={}>
any.name = "Jane Doe"
any['age'] = 47

any['name']         # => "Jane Doe"
any.name            # => "Jane Doe"
any.age             # => 47
any['age']          # => 47
