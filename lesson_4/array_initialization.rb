# Play with nested array initialization for a 3 x 3 TicTacToe board

# 1
# works as expected but is not very elegant if we had larger board
board = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
board[1][1] = "X"
p board

# 2
# not good because new(size, default) reference to the same default object
board = Array.new(3, Array.new(3, " "))
board[1][1] = "X" # affects whole column
p board

# 3
# not good because we push reference to the same row object
initial_row = []
3.times { initial_row.push(" ") }
board = []
3.times { board.push(initial_row) }
board[1][1] = "X" # affects whole column
p board

# 4 OK
board = Array.new(3) { Array.new(3) { " " } }
board[1][1] = "X"
p board

# 5 maybe?
initial_row = []
3.times { initial_row.push(" ".clone) }
board = []
3.times { board.push(initial_row.clone) }
board[1][1] = "X"
p board
