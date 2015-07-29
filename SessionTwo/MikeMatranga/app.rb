require 'csv'

file_path = "./data.csv"

names = []
CSV.foreach(file_path, col_sep: ',', quote_char: '"', headers: :first_row, converters: [:numeric], skip_blanks: true) do |row|
  name_entry = {}
  name_entry[:birth_year] = row['BRTH_YR']
  name_entry[:ethnicity] = row['ETHCTY']
  name_entry[:name] = row['NAME']
  name_entry[:count] = row['CNT']
  names << name_entry
end

puts names
