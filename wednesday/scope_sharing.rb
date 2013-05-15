#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# It is possible to share scope between objects by defining them with blocks

module Kernel
  local_message = "A spoonful "

  define_method :get_message do
    local_message
  end

  define_method :add_sugar do
    local_message += "of sugar "
  end

  define_method :add_medicine do
    local_message += "makes the medicine go down"
  end
end

get_message            # => "A spoonful "
add_sugar              # => "A spoonful of sugar "
add_medicine           # => "A spoonful of sugar makes the medicine go down"
get_message            # => "A spoonful of sugar makes the medicine go down"
defined? local_message # => nil
