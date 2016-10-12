# Calculator refactored

# ask the user for 2 numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results

def prompt(message)
  puts "=> #{message}"
end

def calculator(number1, number2, operation)
  case operation
  when "A"
    number1 + number2
  when "S"
    number1 - number2
  when "M"
    number1 * number2
  when "D"
    divide_integers(number1, number2)
  else
    "Unknown operation. Giving up."
  end
end

def calculation_message(number1, number2, operation)
  hash = { "A" => "Adding", "S" => "Subtracting",
           "M" => "Multiplying", "D" => "Dividing" }
  message = hash[operation]
  return "Unknown operation. Giving up." if message.nil?
  "#{message} #{number1} and #{number2}."
end

def divide_integers(number1, number2)
  if number2.zero?
    "Can't divide by zero."
  else
    number1.to_f / number2.to_f
  end
end

def valid_number?(number)
  if number.nonzero?
    true
  else
    prompt "You did not enter a valid number."
    false
  end
end

def enter_integer(message)
  number = nil
  loop do
    prompt message
    number = gets.chomp().to_i
    break if valid_number?(number)
  end
  number
end

def enter_name
  name = ''
  loop do
    prompt "What is your name?"
    name = gets.chomp()
    if name.empty?
      prompt "Please enter a valid name"
    else
      break
    end
  end
  name
end

def enter_operation
  operation_prompt = <<-MSG
    Enter operation:
    add (A)
    subtract (S)
    multiply (M)
    divide (D)
  MSG
  prompt operation_prompt
  operation = ''
  valid_operation = %w(A S M D)
  loop do
    operation = gets.chomp().upcase
    if valid_operation.include?(operation)
      break
    else
      prompt "Please enter valid operation: A, S, M or D."
    end
  end
  operation
end

# main
prompt "Simple calculator"
name = enter_name
prompt "Hello #{name}"
loop do
  number1 = enter_integer("Enter first integer")
  number2 = enter_integer("Enter second integer")
  operation = enter_operation
  prompt calculation_message(number1, number2, operation)
  prompt "Result: #{calculator(number1, number2, operation)}"
  prompt "Do you want to perform another calculation? Yes (Y), No (N)"
  break unless gets.chomp().upcase == "Y"
end

prompt "Bye #{name}!"
