def count_occurrences(arr)
  hash = {}
  arr.each { |value| hash[value].nil? ? hash[value] = 1 : hash[value] += 1 }
  hash.each { |key, value| puts "#{key} => #{value}" }
end

def count_occurrences2(arr)
  arr.uniq.each { |value| puts "#{value} => #{arr.count(value)}" }
end


vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

count_occurrences(vehicles)
count_occurrences2(vehicles)
