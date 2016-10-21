# 1
if false
  greeting = "hello world"
end

p greeting

# 2
greetings = { a: 'hi' }
informal_greeting = greetings[:a].clone
informal_greeting << ' there'

puts informal_greeting #  => "hi there"
puts greetings

# 3
def mess_with_vars(one, two, three)
  p one.object_id, two.object_id, three.object_id
  one = two
  p one.object_id, two.object_id, three.object_id
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# 5

def is_an_ip_number?(number)
  ("0".."255").include?(number)
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.length != 4
  while dot_separated_words.size > 0
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  true
end

p dot_separated_ip_address?("1.1.1.1.1")
p dot_separated_ip_address?("1.1.1")
p dot_separated_ip_address?("12.45.489.12")
p dot_separated_ip_address?("12.45.42.12")
