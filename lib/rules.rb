class Rules
  attr_reader :this_line

  def initialize(this_line, line_number, line_above = nil)
    @line_above = line_above
    @line_number = line_number + 1
    @this_line = this_line
    @error_messages = []
  end

private

  def first_line
    # p @this_line
    if @line_number == 1
      @error_messages.push(["'{' expected at the beginning of the line", @line_number]) unless @this_line[0] == '{'
    end
  end

  def after_curly
    if @this_line.include? '{'
      @error_messages.push(["New line expected after '{'", @line_number]) unless @this_line[@this_line.index('{') + 1] == "\n"
    end
    if @this_line.include? '}'
      @error_messages.push(["New line expected after '}'", @line_number]) unless @this_line[@this_line.index('}') + 1] == "\n"
    end
  end

  def after_colon
    if @this_line.include? ':'
      @this_line2 = @this_line.split("\"")
      @this_line2.each_with_index do |split, i|
        if split.include?(':') && !@this_line2[i+1].nil? && !split.include?('https')
          next_split = split[split.index(':') + 1]
          @error_messages.push(["Add space after ':'", @line_number]) if next_split  != " "
        end
      end
    end
  end

  #   if @this_line.include? ':'
  #     @error_messages.push(["Space is expected after ':'", @line_number]) unless @this_line[@this_line.index(':') + 1] == " "
  #   end



  def after_comma
    if @this_line.include? ','
      @this_line2 = @this_line.split("\"")
      @this_line2.each_with_index do |split, i|
        if split == ',' && !@this_line2[i+1].nil?
          p @split
          @error_messages.push(["New line expected after ','", @line_number]) if split[split.index(',') + 1] != "\n"
        end
      end
    end
  end

  def after_square_bracket
    if @this_line.include?('[')
      @this_line2 = @this_line.split("\"")
      @this_line2.each_with_index do |split, i|

        if split.include?('[')
      
         @error_messages.push(["New line expected after '['", @line_number]) if split[split.index('[') + 1] != "\n"
        end
      end
    end
    if @this_line.include? '],'
      @error_messages.push(["Empty line is expected after '],'", @line_number]) unless @this_line[@this_line.index(']') + 1] == "\n" || @this_line[@this_line.index(']') + 1] == ',' 
    end
 end


  def before_curly
    if @this_line.include? '}'
      before_split = @this_line[@this_line.index('}') - 1]
      @error_messages.push(["New empty line expected before '}'", @line_number]) unless before_split == "\n" || before_split == " "
    end
  end

  def indentation
    
    @this_line2 = @this_line.split("\"")
    # p @this_line2
    if @this_line.include?("{") || @this_line.include?("}")
      if  count_spaces(@this_line) > 0
       @error_messages.push(["Indentation 0 is expected for '{' and '} ", @line_number])
     end
    elsif @this_line.include?("[") || @this_line.include?("]")
     
      if  count_spaces(@this_line) != 2
       @error_messages.push(["Indentation 2 is expected for '[' and '] insted of #{count_spaces(@this_line)}", @line_number])
     end
   
    elsif @this_line == " \n"
    if count_spaces(@this_line) != 0
      @error_messages.push(["Indentation 0 is expected for empty lines insted of #{count_spaces(@this_line)}", @line_number])
    end
   elsif @this_line != "\n"
    @this_line
    if count_spaces(@this_line) != 4
      @error_messages.push(["Indentation 4 is expected for strings insted of #{count_spaces(@this_line)}", @line_number])
    end
  end
  end

  def count_spaces(line)
    line=line.split("")
   count = 0
    line.each do |crt|
      if crt == ' '
        count += 1
      else
        return count
      end
    end
    count
  end
  def count_error_point

  end





public

  def check_for_errors
    first_line 
    after_curly
    after_colon
    after_comma
    before_curly
    after_square_bracket
    indentation


    @error_messages
  end
end
