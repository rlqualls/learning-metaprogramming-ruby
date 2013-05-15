#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Every method in Ruby is passed a block, whether or not it appears in the arguments

def get_block
  yield
end

get_block { "inside block" } # => "inside block"

def get_block2(&block)
  yield
end

get_block2 { "inside block" } # => "inside block"

# Blocks can use {/} as delimiters or do/end

result = get_block do
  "inside block" 
end

result # => "inside block"

# The "yield" method can pass parameters to the block

def get_block_params(x, y)
  yield(x, y)
end

params = get_block_params(1, 2) do |a, b|
  [a, b]
end

params # => [1, 2]

# What happens if there is more than one yield?

def three_yields(arg)
  yield(arg)
  yield(arg)
  yield(arg)
end

three_result = []
three_yields(three_result) { |passed_in| passed_in << "block execution" }

three_result # => ["block execution", "block execution", "block execution"]

# Each yield executes the block once
# It is also possible to specify the number of yields

def many_yields(number, arg)
  number.times { yield(arg) }
end

many_result = []
many_yields(5, many_result) { |passed_in| passed_in << "value" }

many_result  # => ["value", "value", "value", "value", "value"]

