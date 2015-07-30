require 'csv'

file_path = "./data.csv"

names = []
names_by_ethnicity = {}

CSV.foreach(file_path, col_sep: ',', quote_char: '"', headers: :first_row, converters: [:numeric], skip_blanks: true) do |row|
  name_entry = {}
  name_entry[:birth_year] = row['BRTH_YR']
  name_entry[:name] = row['NAME']
  name_entry[:count] = row['CNT']

  if names_by_ethnicity.has_key?(row['ETHCTY'])
    names_by_ethnicity[row['ETHCTY']] << name_entry
  else
    names_by_ethnicity[row['ETHCTY']] = [name_entry]
  end
  names << name_entry
end

puts names_by_ethnicity['ASIAN AND PACIFIC ISLANDER'].sort_by { |entry| entry[:count] }
