# 1
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
p %w(Fred Barney Wilma Betty BamBam Pebbles)

# 2
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"
p flintstones

# 3
p flintstones << "Dino" << "Hoppy"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.push("Dinno", "Hoppy")
p flintstones.concat(%w(Andy Dandy))

# 4
advice = "Few things in life are as important as house training " \
         "your pet dinosaur."
p advice.slice!(0, advice.index("house"))
p advice
advice = "Few things in life are as important as house training " \
         "your pet dinosaur."
p advice.slice(0, advice.index("house"))
p advice

# 5
statement = "The Flintstones Rock!"
p statement.count("t")
p statement.scan("t").count

# 6
title = "Flintstone Family Members"
p title.length
p size = (41 - title.length) / 2
title = (" " * size) << title << (" " * size)
p title[0, 40]
# nicer way
p "Flintstone Family Members".center(40)
