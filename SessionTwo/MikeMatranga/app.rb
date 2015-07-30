#!/usr/bin/env ruby

require 'csv'

class BabyNameParser

  def initialize(file_path)
    @file_path = file_path
  end

  def args
    {
      'asian' => 'ASIAN AND PACIFIC ISLANDER',
      'black' => 'BLACK NON HISPANIC',
      'hispanic' => 'HISPANIC',
      'white' => 'WHITE NON HISPANIC'
    }
  end

  # given an ethnicity returns the 5 most popular baby names baby name, count
  def baby_names_by_ethnicity(ethinicity)
    parse_baby_names
    x = @names_by_ethnicity[ethinicity].sort_by { |entry| entry[:count] }.reverse!
    x[0..4]
  end

  private

  def parse_baby_names
    names = []
    @names_by_ethnicity = {}

    CSV.foreach(@file_path, col_sep: ',', quote_char: '"', headers: :first_row, converters: [:numeric], skip_blanks: true) do |row|
      name_entry = build_name_entry_from_row(row)

      if @names_by_ethnicity.has_key?(row['ETHCTY'])
        @names_by_ethnicity[row['ETHCTY']] << name_entry
      else
        @names_by_ethnicity[row['ETHCTY']] = [name_entry]
      end
      names << name_entry
    end
    names
  end

  def build_name_entry_from_row(row)
    name_entry = {}
    name_entry[:birth_year] = row['BRTH_YR']
    name_entry[:name] = row['NAME']
    name_entry[:count] = row['CNT']
    name_entry
  end
end

class BabyNamePrinter
  def print_baby_names_with_count(name_entries)
    output_string = ''

    name_entries.each do |entry|
      output_string << "Name: " << entry[:name] << " Count: " << entry[:count].to_s << "\n"
    end

    output_string
  end
end


parser = BabyNameParser.new("./data.csv")
printer = BabyNamePrinter.new

if parser.args.has_key?(ARGV[0])
  names = parser.baby_names_by_ethnicity(parser.args[ARGV[0]])
  puts printer.print_baby_names_with_count(names)
else
  puts "possibilities: asian, black, hispanic, white"
end



