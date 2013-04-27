#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# The respond_to? method returns whether an object knows how to respond to a message
# The message can be described with a symbol or a string

String.new.respond_to?(:chop)  # => true
String.new.respond_to?('chop') # => true

# Take note that class objects do not respond to instance methods
# And instance objects do not respond to class methods

Array.respond_to?(:push)      # => false
Array.respond_to?(:new)       # => true
 
Array.new.respond_to?(:push)  # => true
Array.new.respond_to?(:new)   # => false

# respond_to? can take arguments with the message as well

Array.new.respond_to?('push', 'a') # => true
