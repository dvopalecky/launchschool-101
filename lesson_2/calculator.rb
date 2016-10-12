# ask the user for 2 numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results

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

def divide_integers(number1, number2)
  if number2.zero?
    "Can't divide by zero."
  else
    number1.to_f / number2.to_f
  end
end

puts "Simple calculator"
puts "Enter first integer:"
number1 = gets.chomp().to_i
puts "Enter second integer:"
number2 = gets.chomp().to_i
puts "Enter operation: add (A), subtract (S), multiply (M), divide (D)"
operation = gets.chomp()
puts "Result: #{calculator(number1, number2, operation)}"
