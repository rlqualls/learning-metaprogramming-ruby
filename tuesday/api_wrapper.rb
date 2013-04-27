#!/usr/bin/env ruby
# Copyright Robert Qualls 2013

# Defining methods for every api service method is not very DRY
# Fortunately, we can use "method_missing" to create a clean api wrapper
#  that can support all current and future api methods

require 'open-uri'
require 'json'

class OpenLibrary
  @@url = "http://openlibrary.org/" 
  def self.method_missing(method, *args)
    @@url += method.to_s + '/'
    # OpenLibrary is the superclass here
    Class.new OpenLibrary do 
      def self.method_missing(method, *args)
        if method.to_s == "json" 
          url = @@url.chop + ".json"
          # reset
          @@url = "http://openlibrary.org/"
          JSON.parse(open(url).read)
        else
          # recursion if not "json"
          super
        end
      end
    end
  end
end

# Now with OpenLibrary, it is possible to chain method calls instead of
#  passing in a url

works = OpenLibrary.authors.OL1A.works.json
works["entries"].size # => 16
works["entries"][1..3].each do |entry|
  entry.keys.each do |key|
    puts "#{key} = #{entry[key]}"
  end
end

# >> title = Uttara-kaksha
# >> created = {"type"=>"/type/datetime", "value"=>"2010-03-12T21:22:12.377673"}
# >> last_modified = {"type"=>"/type/datetime", "value"=>"2010-03-12T21:22:12.377673"}
# >> subject_people = ["Sachi Routray (1916-)"]
# >> key = /works/OL14930762W
# >> authors = [{"type"=>{"key"=>"/type/author_role"}, "author"=>{"key"=>"/authors/OL1A"}}]
# >> latest_revision = 1
# >> subject_times = ["20th century"]
# >> type = {"key"=>"/type/work"}
# >> subjects = ["Biography", "Oriya Authors"]
# >> revision = 1
# >> subtitle = Oḍiākāvyasya Saṃskr̥tānuvādaḥ
# >> title = Bājirāuta
# >> created = {"type"=>"/type/datetime", "value"=>"2010-03-12T21:22:14.149023"}
# >> last_modified = {"type"=>"/type/datetime", "value"=>"2010-03-12T21:22:14.149023"}
# >> subject_people = ["Bāji Rāuta (1925-1938)"]
# >> key = /works/OL14930765W
# >> authors = [{"type"=>{"key"=>"/type/author_role"}, "author"=>{"key"=>"/authors/OL1A"}}]
# >> latest_revision = 1
# >> type = {"key"=>"/type/work"}
# >> subjects = ["Poetry"]
# >> revision = 1
# >> title = Kabitā-2003
# >> created = {"type"=>"/type/datetime", "value"=>"2010-03-12T21:22:02.215787"}
# >> last_modified = {"type"=>"/type/datetime", "value"=>"2010-03-12T21:22:02.215787"}
# >> latest_revision = 1
# >> key = /works/OL14930753W
# >> authors = [{"type"=>{"key"=>"/type/author_role"}, "author"=>{"key"=>"/authors/OL1A"}}]
# >> type = {"key"=>"/type/work"}
# >> id = 49290110
# >> revision = 1
