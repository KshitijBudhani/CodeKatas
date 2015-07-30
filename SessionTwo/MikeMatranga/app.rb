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

  def baby_names_by_ethnicity(ethinicity)
    parse_baby_names
    @names_by_ethnicity[ethinicity]
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

parser = BabyNameParser.new("./data.csv")

if parser.args.has_key?(ARGV[0])
  puts parser.baby_names_by_ethnicity(parser.args[ARGV[0]])
else
  puts "possibilities: asian, black, hispanic, white"
end
