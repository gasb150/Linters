# require 'jsonlint'
require './lib/rules'
require 'colorize'

flag = ARGV[0]

Dir.glob("**/*.json").each do |file_name|
  file = File.read(file_name)

  array = file.each_line.to_a
  file2 = File.open(file_name)
if flag == '--fix'
  p 'lll'
else 
  puts "Checking #{file_name}".yellow
  errors_counter = 0
  array.each_with_index do |l, i|
    lin = 0
    line = i.zero? ? Rules.new(l, i) : Rules.new(l, i, array[i - 1], lin)
    line_errors = line.check_for_errors
    line_errors.each do |errors|
      puts "Line #{errors[1]}-#{errors[2]}: ".red + errors[0]
    end
    errors_counter += line_errors.length
  end
  puts "Total errors to solve" + "#{errors_counter}".red if !errors_counter.zero?
  puts "No errors found for #{file_name}".green if errors_counter.zero?
end
end
