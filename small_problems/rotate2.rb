def rotate_array(arr)
  arr[1..-1] << arr[0]
end

def rotate_rightmost_digits(number, nb_digits)
  digit_arr = number.to_s.chars
  nb_digits = [digit_arr.size, nb_digits].min # protect against large nb_digits
  righmost_digits = rotate_array(digit_arr[- nb_digits..-1])
  new_digit_arr = digit_arr[0..- nb_digits - 1] + righmost_digits
  new_digit_arr.join.to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917
