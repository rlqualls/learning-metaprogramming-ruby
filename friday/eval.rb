#!/usr/bin/env ruby  
# Copyright Robert Qualls 2013

# The "eval" kernel method can be used to execute code in string format

eval "2 > 3" # => false

# This is useful for constructing methods that dynamically execute code
# For example, code downloaded from a network or inputted by a user

class Array
  def perform(method)
    eval("self.#{method}")
  end
end

[1,2,3,4,5].perform("size") # => 5

# The problem is that eval can potentially execute undesirable methods
# Like wiping a hard drive or obtaining private data

[1,2,3,4,5].perform("size; Dir.glob ('/*')")[0..5] # => ["/lib", "/boot", "/home", "/var", "/etc", "/sbin"]

# This is referred to as code injection
# One way around this problem is to use "send" instead of "eval"

class Array
  def safe_perform(method, *arguments)
    send(method, *arguments)
  end
end

[1,2,3,4,5].safe_perform("size") # => 5
injection_try = 
  begin
    [1,2,3,4,5].safe_perform("size; Dir.glob('/*')")
  rescue NoMethodError => error
    "#{error}"
  end

injection_try # => "undefined method `size; Dir.glob('/*')' for [1, 2, 3, 4, 5]:Array"

# Another alternative is to use safe levels
# Source: "http://phrogz.net/ProgrammingRuby/taint.html"
# Ruby defines a global variable $SAFE which can range from 0 to 4+
#   0 - no checking of data from external origins (tainted data) is performed
#   1 - ruby disallows the use of tainted data by potentially dangerous operations
#   2 - ruby prohibits loading of program files from globally writable locations
#   3 - ruby considers all newly created objects as tainted by default
# >=4 - military strict. Nontainted objects may not be modified

# Let's see what happens when we set $SAFE to 3 and try to execute eval

$SAFE = 3  
dangerous_code = "'dangerous hacker codes'"
dangerous_code.tainted? # => true
result =
  begin
    eval(dangerous_code)
  rescue SecurityError => error
    "#{error}"
  end

result # => "Insecure operation - eval"
