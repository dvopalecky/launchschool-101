def is_odd?(number)
  number.abs % 2 == 1
end

puts is_odd?(0)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
