class Rules
  attr_reader :this_line

  def initialize(this_line, line_number, line_above = nil)
    @line_above = line_above
    @line_number = line_number + 1
    @this_line = this_line
    @error_messages = []
  end

end 