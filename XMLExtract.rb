#!/usr/bin/env ruby
begin
  require 'pry'
  require 'zipruby'
  require 'rexml/document'
  require 'nokogiri'
rescue LoadError
  puts "Error loading dependencies run \'bundle install\' first."
  exit!
end

unless ARGV.length > 0
  puts "Please specify a .docx file to export the XML from."
  exit!
end

def pretty_print(xml)
  rex = REXML::Document.new(xml)
  clean = String.new
  rex.write(clean, 1)
  return Nokogiri::XML(clean)
end

document = Zip::Archive.open(ARGV[0])
unclean_xml = document.fopen('word/document.xml').read
puts pretty_print(unclean_xml)