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

  def after_colon
    if @this_line.include? ':'
      @error_messages.push(["Space is expected after ':'", @line_number]) unless @this_line[@this_line.index('  ') + 1] == " "
    end
  end

  def after_comma
    if @this_line.include? ','
      @error_messages.push(["New line expected after ','", @line_number]) if @this_line[@this_line.index(',') + 1] != "\n"
    end
  end

  def after_square_bracket
    if @this_line.include? '],'
      @error_messages.push(["Empty line is expected after '],'", @line_number]) unless @this_line[@this_line.index(']') + 1] == "\n"
    end
  end

  def after_curly
    if @this_line.include? '}'
      @error_messages.push(["New line expected after '}'", @line_number]) unless @this_line[@this_line.index('}') + 1] == "\n"
    end
  end
=begin
  def indentation
    no_indent = 0
    indent = 0

    if @this_line.include? "{"
      @error_messages.push(["New line expected after ''", @line_number]) unless @this_line[@this_line.index('{') + 1] == "\n"
    end
  end
=end


  def check_for_errors
    first_line 
    after_curly
    after_colon
    after_comma
    after_curly
    after_square_bracket
    #indentation


    @error_messages
  end
end
