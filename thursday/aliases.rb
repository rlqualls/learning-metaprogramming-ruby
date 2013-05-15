#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# The alias keyword can be used to add a name for a method
# Notice that alias is a keyword and not a method, therefore
#   - the method names are not symbols, so no colons
#   - alias is not a method call, so no comma
# Aliasing does not affect the aliased method

class String
 alias new_length length  
end

"War of The Worlds".length     # => 17
"War of The Worlds".new_length # => 17

# alias_method can be used instead of the alias keyword
# Since it is a method call, the methods passed in are symbols

class Array
  alias_method :new_size, :size 
end

[1,2,3,4,5].size     # => 5
[1,2,3,4,5].new_size # => 5

# Sometimes it is nice to add behavior to a method without knowing the method's
#  original behavior
# In most languages, this is done via subclassing and calling the parent
#  method in the subclassed method
# However, this is not ideal in certain situations, like adding functionality
#  to a Kernel method
# The "around alias" technique can be used to add functionality to a method

class String
  alias original_length length

  def length
    "This length method has been altered!"
  end
end

"War of the Worlds".length          # => "This length method has been altered!"
"War of the Worlds".original_length # => 17

# original_length is able to reference the original method because def does 
#  not change length, but merely adds another method of the same name

# What if alias comes after def?

class Array
  def size
    "This size method has been altered!"
  end

  alias not_original_size size
end

[1,2,3,4,5].size              # => "This size method has been altered!"
[1,2,3,4,5].not_original_size # => "This size method has been altered!"

# The original size method still exists, but "size" no longer refers to it
# Since alias comes after the redefinition, the newly added method definition 
#  is aliased instead of the old one
