class NameEntry
  def initialize(entry)
    @name = entry['NAME']
    @count_string = entry['CNT'].to_s
    @count = entry['CNT']
    @ethnicity = entry['ETHCTY']
    @birth_year = entry['BRTH_YR']
  end

  def name_with_count
    "Name: #{@name} Count: #{@count_string}"
  end

  def ethnicity_with_count
    "Ethnicity: #{@ethnicity} Count: #{@count_string}"
  end

  def count
    @count
  end

  def ethnicity
    @ethnicity
  end

  def name
    @name
  end
end
