#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Any reference in Ruby that begins with an uppercase letter is a constant

module MyModule

  MyConst = 'Some Outer Constant'

  class MyClass

    MyConst = 'Some Inner Constant'
  end
end

# Constants can be accessed like files in a directory

MyModule::MyClass           # => MyModule::MyClass
MyModule::MyConst           # => "Some Outer Constant"
MyModule::MyClass::MyConst  # => "Some Inner Constant"

# Notice that MyClass::MyConst did not override MyModule::MyConst

# It is also possible to get a constant's constants

MyModule.constants          # => [:MyConst, :MyClass]
MyModule::MyClass.constants # => [:MyConst]

# Ruby does not care how you organize constants

module HardDrive
  module DriveC 
    class Windows
    end
  end

  class DriveD
    class Media
      module Music
      end
    end
  end
end

HardDrive::DriveC::Windows      # => HardDrive::DriveC::Windows
HardDrive::DriveD::Media::Music # => HardDrive::DriveD::Media::Music

# The Module.nesting method is available to get the current path

module X
  class C
    module D
      Module.nesting # => [X::C::D, X::C, X]
    end
  end
end

# Ruby assumes a leading double colon to refer to the root constant
# This can be useful in deeply nested hierarchies

class C
  module A
    class B
      class X
        Str = 'deeply nested constant'
      end
      class Y
        module M
          ::C::A::B::X::Str # => "deeply nested constant"
        end
      end
    end
  end
end
