# Calculator refactored

# ask the user for 2 numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results

LANGUAGE = 'en'

require 'yaml'

def prompt(message)
  message.split("\n").each do |line|
    puts "=> #{line}"
  end
end

MESSAGES = YAML.load_file('calculator_msg.yml')[LANGUAGE]
if MESSAGES.nil?
  prompt "Unknown language"
  exit
end

def calculator(number1, number2, operation)
  case operation
  when MESSAGES['operation_add_abr'] then number1 + number2
  when MESSAGES['operation_subtract_abr'] then number1 - number2
  when MESSAGES['operation_multiply_abr'] then number1 * number2
  when MESSAGES['operation_divide_abr'] then divide_integers(number1, number2)
  else MESSAGES['unknown_operation']
  end
end

def calculation_message(number1, number2, operation)
  hash = { MESSAGES['operation_add_abr'] => MESSAGES['operation_add_process'],
           MESSAGES['operation_subtract_abr'] =>
             MESSAGES['operation_subtract_process'],
           MESSAGES['operation_multiply_abr'] =>
             MESSAGES['operation_multiply_process'],
           MESSAGES['operation_divide_abr'] =>
             MESSAGES['operation_divide_process'] }
  message = hash[operation]
  return MESSAGES['unknown_operation'] if message.nil?
  "#{message} #{number1} and #{number2}."
end

def divide_integers(number1, number2)
  if number2.zero?
    MESSAGES['divide_by_zero']
  else
    number1.to_f / number2.to_f
  end
end

def valid_integer?(input_str)
  input_str.to_i.to_s == input_str
end

def valid_operation?(operation)
  valid_operation = [MESSAGES['operation_add_abr'],
                     MESSAGES['operation_subtract_abr'],
                     MESSAGES['operation_multiply_abr'],
                     MESSAGES['operation_divide_abr']]
  valid_operation.include?(operation)
end

def enter_integer(message)
  loop do
    prompt message
    number = gets.chomp()
    if valid_integer?(number)
      return number.to_i
    else
      prompt MESSAGES['invalid_number']
    end
  end
end

def enter_name
  loop do
    prompt MESSAGES['name?']
    name = gets.chomp()
    if name.empty?
      prompt MESSAGES['invalid_name']
    else
      return name
    end
  end
end

def enter_operation
  loop do
    operation = gets.chomp().upcase
    if valid_operation?(operation)
      return operation
    else
      prompt MESSAGES['invalid_operation']
    end
  end
end

def calculate_again?
  loop do
    answer = gets.chomp
    if answer.casecmp(MESSAGES['yes_abr']).zero?
      return true
    elsif answer.casecmp(MESSAGES['no_abr']).zero?
      return false
    else
      prompt MESSAGES['invalid_yes_no']
    end
  end
end

# main
prompt MESSAGES['welcome']
name = enter_name
prompt "#{MESSAGES['hello']} #{name}"
loop do
  number1 = enter_integer(MESSAGES['enter_first'])
  number2 = enter_integer(MESSAGES['enter_second'])
  prompt MESSAGES['choose_operation']
  operation = enter_operation
  prompt calculation_message(number1, number2, operation)
  prompt "#{MESSAGES['result']}: #{calculator(number1, number2, operation)}"
  prompt MESSAGES['new_calculation?']
  break unless calculate_again?
end
prompt "#{MESSAGES['bye']} #{name}!"
