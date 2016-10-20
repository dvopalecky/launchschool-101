# 1
(0..9).each { |i| puts ' ' * i + "Flinstones rock" }
10.times { |number| puts ' ' * number + "Flinstones rock" }

# 2
statement = "The Flintstones Rock"
# solution 1
hash = {}
statement.each_char do |c|
  if hash[c]
    hash[c] += 1
  else
    hash[c] = 1
  end
end
p hash

# proposed solution
hash = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  count = statement.scan(letter).count
  hash[letter] = count if count > 0
end
p hash

# 3
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"

# 4
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# 5
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

p factors(12)

# 6
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

rb = (10..13).to_a
5.times do |i|
  p rb = rolling_buffer2(rb, 5, i)
end

# 7

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 200)
puts "result is #{result}"

# 8
def titleize(str)
  str.split.each(&:capitalize!).join(' ')
end

p titleize('ahoj jak se máš?')

# 9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

munsters.each_pair do |_, value|
  value["age_group"] = \
    case value["age"]
    when 0..17 then "kid"
    when 18..64 then "adult"
    else "senior"
    end
end

p munsters
