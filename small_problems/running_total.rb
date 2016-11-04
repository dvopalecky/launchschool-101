# Write a method that takes an Array of numbers, and returns an Array
# with the same number of elements, and each element has the running
# total from the original Array.

def running_total(arr)
  total = 0
  arr.map do |value|
    total += value
  end
end

# Test Cases
p running_total([2, 5, 13]) == [2, 7, 20] # => true
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67] # => true
p running_total([-5]) == [-5] # => true
