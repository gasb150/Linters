
=begin
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
  
    def indentation
  no_indent = 0
  indent = 0

    if @this_line.include? "{"
      @error_messages.push(["New line expected after ''", @line_number]) unless @this_line[@this_line.index('{') + 1] == "\n"
    end
end

  def check_for_errors
    first_line 
    after_curly
    after_colon
    #after_comma
    after_curly
    #indentation
    after_square_bracket


    @error_messages
  end
=end