#!/usr/bin/env ruby

load 'parser.rb'
load 'printer.rb'

parser = Parser.new("./data.csv")
printer = Printer.new

if parser.args.has_key?(ARGV[0])
  names = parser.baby_names_by_ethnicity(parser.args[ARGV[0]])
  puts printer.print_baby_names_with_count(names)
else
  puts "possibilities: asian, black, hispanic, white"
end
