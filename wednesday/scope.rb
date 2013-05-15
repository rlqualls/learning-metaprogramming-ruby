#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# There are three keywords in Ruby that break scope
#  - module
#  - class
#  - def

top_var = "can see top"

local_variables # => [:top_var, :_xmp_1368594100_7848_993032, :flat_top_var, :after_flat_scope_var]
module ScopeModule
  module_var = "can see module"      
  local_variables # => [:module_var, :_xmp_1368594100_7848_993032]
  class ScopeClass
    class_var = "can see class"     
    local_variables # => [:class_var, :_xmp_1368594100_7848_993032]

    def scope_method
      method_var = "can see method"   
      local_variables 
    end
  end
end

ScopeModule::ScopeClass.new.scope_method # => [:method_var]

# ScopeModule cannot access local_var 
# ScopeClass cannot access local_var or module_var
# scope_method cannot access local_var, module_var, or class_var

# Unlike module, class, or method definitions, blocks don't  break scope in Ruby
# Since it is possible to create modules, classes, and methods using blocks, it
#  is possible to enable scope-sharing between them

flat_top_var = "flat scope top var"
FlatScopeModule = Module.new do
  
  flat_module_var = "flat scope module var"
  local_variables # => [:flat_module_var, :top_var, :_xmp_1368594100_7848_993032, :flat_top_var, :after_flat_scope_var]
  
  FlatScopeClass = Class.new Object do
    
    flat_class_var = "flat scope class var"    
    local_variables # => [:flat_class_var, :flat_module_var, :top_var, :_xmp_1368594100_7848_993032, :flat_top_var, :after_flat_scope_var]

 end 
end

after_flat_scope_var = "after flat scope"

# In this example, FlatScopeClass has access to all variables defined at
#  previous levels, including variables defined later on 
