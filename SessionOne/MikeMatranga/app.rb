INDENT     = "("
NEW_LINE   = "\n"
OUTDENT    = ")"
SEPARATOR  = ","
WHITESPACE = " "

indent_level = -1
output_string = ""
"(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))".split("").each do |char|
  indent_level += 1 if char == INDENT
  indent_level -= 1 if char == OUTDENT

  if [INDENT, SEPARATOR].include?(char)
    output_string << NEW_LINE
    indent_level.times { output_string << "-" }
    output_string << " " if indent_level > 0
  else
    output_string << char unless [OUTDENT, WHITESPACE].include?(char)
  end
end

puts output_string

