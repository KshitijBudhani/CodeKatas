class Printer
  def print(name_entries)
    output_string = ''

    name_entries.each do |entry|
      output_string << entry.description << "\n"
    end

    output_string
  end
end
