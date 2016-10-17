# 1
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# 2
# Describe the difference between ! and ? in Ruby. 
# And explain what would happen in the following scenarios:

# what is != and where should you use it?
# >> means NOT EQUAL, used in conditional statements

# put ! before something, like !user_name
# >> means NOT, logical negation

# put ! after something, like words.uniq!
# >> usually (by convetion) it means that the method is destructive,
# >> i.e. that it mutates the caller

# put ? before something
# >> can be used in ternary operator, e.g. x = condition ? true_statement : false_statement

# put ? after something
# >> usually means that method return a boolean (true or false)
# >> or that variable contains boolean

# put !! before something, like !!user_name
# double negation, or putting object into boolean equivalent
p !!323
p !!nil
p !!"hello"

# 3
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.gsub(/important/, 'urgent')

# 4
numbers = [1, 2, 3, 4, 5, 1]
numbers.delete_at(1) # deletes at index 1
p numbers
numbers = [1, 2, 3, 4, 5, 1]
numbers.delete(1) # deletes all values of 1
p numbers

# 5
p (10..100).include?(42.5)
p (10..100).cover?(42.5)

# 6
famous_words = "seven years ago..."
in_front = "Four score and "
p in_front + famous_words
p "#{in_front}#{famous_words}"
p in_front << famous_words

# 7
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep
p eval(how_deep)

# 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
p flintstones
flintstones.flatten!
p flintstones

# 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
p flintstones.to_a[2]
p flintstones.assoc("Barney")

# 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
hash = {}
flintstones.each_with_index do |value, index|
  hash[value] = index
end
p hash
