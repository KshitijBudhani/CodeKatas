class Printer
  def print_baby_names_with_count(name_entries)
    output_string = ''

    name_entries.each do |entry|
      output_string << entry.name_with_count << "\n"
    end

    output_string
  end
end
