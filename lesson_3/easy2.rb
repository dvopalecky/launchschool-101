# 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.include?('Spot')
p ages.key?('Spot')
p ages.member?('Spot')

# 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10,
         "Marilyn" => 22, "Spot" => 237 }
sum_ages = 0
ages.each_value do |v|
  sum_ages += v
end
p sum_ages
p ages.values.inject(:+)

# 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.reject! do |_, v|
  v >= 100
end
p ages

# 4
munsters_description = "The Munsters are creepy in a good way."
p munsters_description.capitalize
p munsters_description.swapcase
p munsters_description.downcase
p munsters_description.upcase

# 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
p ages.merge!(additional_ages)

# 6
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10,
         "Marilyn" => 22, "Spot" => 237 }
p ages.values.min

# 7
advice = "Few things in life are as important as house training your " \
         "pet Dinosaur."
p advice
p advice.match("Dino")

# 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.index { |x| x.start_with?("Be") }

# 9
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! do |v|
  v[0..2]
end
p flintstones

# 10
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |v| v[0..2] }
p flintstones
