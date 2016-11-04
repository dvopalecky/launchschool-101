def unegyptian(arr_denominators)
  arr_denominators.inject(Rational(0, 1)) do |rational_sum, denominator|
    rational_sum + Rational(1, denominator)
  end
end

def egyptian(rational_number)
  denominator = 0
  arr = []
  loop do
    # largest D for which 1 / D <= rational number
    denominator_of_smallest_fraction = (1 / rational_number).ceil
    denominator = [denominator + 1, denominator_of_smallest_fraction].max
    arr.push(denominator)
    rational_number -= Rational(1, denominator)
    break if rational_number.zero?
  end
  arr
end

# Examples:
p egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
p egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
p egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)
