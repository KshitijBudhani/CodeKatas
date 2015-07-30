require 'csv'
load 'name_entry.rb'

class Parser
  def initialize(file_path)
    @file_path = file_path
  end

  def ethnicity_args
    {
      'asian' => 'ASIAN AND PACIFIC ISLANDER',
      'black' => 'BLACK NON HISPANIC',
      'hispanic' => 'HISPANIC',
      'white' => 'WHITE NON HISPANIC'
    }
  end

  # given an ethnicity returns the 5 most popular baby names baby name, count
  def baby_names_by_ethnicity(ethnicity)
    parse_baby_names
    @names_by_ethnicity[ethnicity].sort_by { |entry| entry.count }.reverse![0..4]
  end

  def ethnicity_stats_for_name(name)
    parse_baby_names
    @ethinicity_count_by_name[name].sort_by { |entry| entry.count }.reverse!
  end

  private

  def parse_baby_names
    @names_by_ethnicity = {}
    @ethinicity_count_by_name = {}

    CSV.foreach(@file_path, col_sep: ',', quote_char: '"', headers: :first_row, converters: [:numeric], skip_blanks: true) do |row|
      name_entry = build_name_entry_from_row(row)

      if @names_by_ethnicity.has_key?(name_entry.ethnicity)
        @names_by_ethnicity[name_entry.ethnicity] << name_entry
      else
        @names_by_ethnicity[name_entry.ethnicity] = [name_entry]
      end

      if @ethinicity_count_by_name.has_key?(name_entry.name)
        @ethinicity_count_by_name[name_entry.name] << name_entry
      else
        @ethinicity_count_by_name[name_entry.name] = [name_entry]
      end
    end
  end

  def build_name_entry_from_row(row)
    NameEntry.new(row)
  end
end
