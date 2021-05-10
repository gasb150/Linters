class Rules
  attr_reader :this_line

  def initialize(this_line, line_number, line_above = nil)
    @line_above = line_above
    @line_number = line_number + 1
    @this_line = this_line
    @error_messages = []
  end

  def first_line
    if @line_number == 1
      @error_messages.push(["'{' expected at the beginning of the line", @line_number]) unless @this_line[0] == '{'
    end
  end

  def after_curly
    if @this_line.include? '{'
      @error_messages.push(["New line expected after '{'", @line_number]) unless @this_line[@this_line.index('{') + 1] == "\n"
    end
  end

  def check_for_errors
    first_line 
    after_curly

    @error_messages
  end
  
end 