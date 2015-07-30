#!/usr/bin/env ruby

load 'parser.rb'
load 'printer.rb'

parser = Parser.new("./data.csv")
printer = Printer.new

if parser.ethnicity_args.has_key?(ARGV[0])
  names = parser.baby_names_by_ethnicity(parser.ethnicity_args[ARGV[0]])
  puts printer.print_baby_names_with_count(names)
else
  stats = parser.ethnicity_stats_for_name(ARGV[0])
  if stats.nil?
    puts "No results for #{ARGV[0]}"
  else
    puts printer.print_ethnicity_stats(stats)
  end
end
