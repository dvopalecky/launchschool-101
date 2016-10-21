# 1
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

sum = 0
munsters.each_value do |v|
  sum += v["age"] if v["gender"] == "male"
end
p sum

# 2
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

munsters.each { |k, v| puts "#{k} is #{v['age']} years old #{v['gender']}" }

# 3
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

def clear_method1(a_string_param)
  a_string_param += "rutabaga"
end

def clear_method2!(an_array_param)
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
clear_method1(my_string)
clear_method2!(my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# proposed solution
def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# 4
sentence = "Humpty Dumpty sat on a wall."
p sentence.split.reverse.join(" ")

# proposed solution
words = sentence.split(/\W/) # split by non-word character
words.reverse!
p words.join(' ') + '.'

# 5
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

# 6
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

p munsters.values
p mess_with_demographics(munsters)
p munsters

# 7
def rps(fist1, fist2)
  if fist1 == "rock"
    fist2 == "paper" ? "paper" : "rock"
  elsif fist1 == "paper"
    fist2 == "scissors" ? "scissors" : "paper"
  else
    fist2 == "rock" ? "rock" : "scissors"
  end
end

p rps("rock", "scissors")
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")

# 8
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

p bar(foo)
