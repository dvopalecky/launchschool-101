# Write a method that displays an 8-pointed star in an nxn grid, where n is an
# odd integer that is supplied as an argument to the method. The smallest such
# star you need to handle is a 7x7 grid.

def star(n)
  # create n x n nested array with ' ' as default value
  matrix = Array.new(n) { Array.new(n) { ' ' } }
  middle_index = (n - 1) / 2
  n.times do |i|
    matrix[middle_index][i] = '*' # horizontal
    matrix[i][middle_index] = '*' # vertical
    matrix[i][i] = '*' # main diagonal
    matrix[- i - 1][i] = '*' # second diagonal
  end
  # output
  matrix.each do |row|
    puts row.join("")
  end
end

star(13)
