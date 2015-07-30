#!/usr/bin/env ruby

load 'parser.rb'
load 'printer.rb'

parser = Parser.new("./data.csv")
printer = Printer.new

possible_ethnicities = parser.ethnicity_args
name_or_ethnicity = ARGV[0]

if possible_ethnicities.has_key?(name_or_ethnicity)
  names = parser.baby_names_by_ethnicity(possible_ethnicities[name_or_ethnicity])
  puts printer.print(names)
else
  stats = parser.ethnicity_stats_for_name(name_or_ethnicity)
  if stats.nil?
    puts "No results for #{name_or_ethnicity}"
  else
    puts printer.print(stats)
  end
end
