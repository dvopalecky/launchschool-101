# Calculator refactored

# ask the user for 2 numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results

LANGUAGE = 'en'

require 'yaml'

MESSAGES = YAML.load_file('calculator_msg.yml')[LANGUAGE]
if MESSAGES.nil?
  prompt "Unknown language"
  exit
end

def prompt(message)
  message.split("\n").each do |line|
    puts "=> #{line}"
  end
end

def calculator(number1, number2, operation)
  case operation
  when MESSAGES['operation_add_abr']
    number1 + number2
  when MESSAGES['operation_subtract_abr']
    number1 - number2
  when MESSAGES['operation_multiply_abr']
    number1 * number2
  when MESSAGES['operation_divide_abr']
    divide_integers(number1, number2)
  else
    MESSAGES['unknown_operation']
  end
end

def calculation_message(number1, number2, operation)
  hash = { MESSAGES['operation_add_abr'] => MESSAGES['operation_add_process'],
           MESSAGES['operation_subtract_abr'] => MESSAGES['operation_subtract_process'],
           MESSAGES['operation_multiply_abr'] => MESSAGES['operation_multiply_process'],
           MESSAGES['operation_divide_abr'] => MESSAGES['operation_divide_process'] }
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

def integer?(input_str)
  input_str.to_i.to_s == input_str
end

def valid_number?(number)
  if integer?(number)
    true
  else
    prompt MESSAGES['invalid_number']
    false
  end
end

def enter_integer(message)
  number = nil
  loop do
    prompt message
    number = gets.chomp()
    break if valid_number?(number)
  end
  number.to_i
end

def enter_name
  name = ''
  loop do
    prompt MESSAGES['name?']
    name = gets.chomp()
    if name.empty?
      prompt MESSAGES['invalid_name']
    else
      break
    end
  end
  name
end

def enter_operation
  prompt MESSAGES['choose_operation']
  operation = ''
  valid_operation = [MESSAGES['operation_add_abr'],
                     MESSAGES['operation_subtract_abr'],
                     MESSAGES['operation_multiply_abr'],
                     MESSAGES['operation_divide_abr']]
  loop do
    operation = gets.chomp().upcase
    if valid_operation.include?(operation)
      break
    else
      prompt MESSAGES['invalid_operation']
    end
  end
  operation
end

# main
prompt MESSAGES['welcome']
name = enter_name
prompt "#{MESSAGES['hello']} #{name}"
loop do
  number1 = enter_integer(MESSAGES['enter_first'])
  number2 = enter_integer(MESSAGES['enter_second'])
  operation = enter_operation
  prompt calculation_message(number1, number2, operation)
  prompt "#{MESSAGES['result']}: #{calculator(number1, number2, operation)}"
  prompt MESSAGES['new_calculation?']
  break unless gets.chomp().upcase == MESSAGES['yes_abr']
end

prompt "#{MESSAGES['bye']} #{name}!"
