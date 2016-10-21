def joinor(array, delimiter = ", ", final_delimiter = "or")
  return array.join(delimiter) if array.size <= 1
  array[0,array.last - 1].join(delimiter) + 
    delimiter + final_delimiter + " " + array.last.to_s
end

def joinor2(arr, delimiter=', ', word='or')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
end

p joinor([])
p joinor([1])
p joinor([1, 2])     
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"

board = {1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "O", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
line = [1,2,3]
p board.select{|k,v| line.include?(k) && v == ' '}.keys.first