# Tic Tac Toe Game
require 'pry'

INITIAL_MARKER = " ".freeze
PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
DASHED_ROW = "+-----" * 3 + "+"
EMPTY_ROW = "|     " * 3 + "|"
POINTS_TO_WIN = 3

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts "=> " + message
end

def display(board, scores)
  clear_screen
  puts "Overall score: #{scores['player']} : #{scores['computer']} " \
       "(Player : Computer)"
  puts "You are #{PLAYER_MARKER}, computer is #{COMPUTER_MARKER}"
  puts DASHED_ROW
  board.each do |row|
    puts EMPTY_ROW
    puts "|  " + row.join("  |  ") + "  |"
    puts EMPTY_ROW
    puts DASHED_ROW
  end
end

def full?(board)
  !board.flatten.include?(INITIAL_MARKER)
end

def winner_array?(array, player)
  array.uniq == [player]
end

def enter_value_in_range(range)
  loop do
    answer = gets.chomp
    return answer if range.include?(answer)
    prompt "Please enter value between #{range.first} and #{range.last}"
  end
end

def player_choose_square(board)
  loop do
    prompt "Enter square (1 ... 9)"
    answer = enter_value_in_range("1".."9").to_i
    break if edit!(board, PLAYER_MARKER, answer)
    prompt "Square is already filled"
  end
end

def computer_choose_square(board)
  loop do
    break if edit!(board, COMPUTER_MARKER, (1..9).to_a.sample)
  end
end

def edit!(board, input, position)
  pos_base3 = "00" + (position - 1).to_s(3)
  pos_base3 = pos_base3[-2, 2] # base 3 with leading zeros
  if board[pos_base3[0].to_i][pos_base3[1].to_i] == INITIAL_MARKER
    board[pos_base3[0].to_i][pos_base3[1].to_i] = input
  end
  # returns nil if condition not met
end

def play_again?
  prompt "Do you want to play whole game again? (Y)es or (N)o"
  loop do
    case gets.chomp
    when "y", "Y" then return true
    when "n", "N" then return false
    else prompt "Please enter Y or N"
    end
  end
end

def check_winner(board)
  if winner?(board, COMPUTER_MARKER)
    return "computer"
  elsif winner?(board, PLAYER_MARKER)
    return "player"
  end
  false
end

def diagonal(board, type = 1)
  case type
  when 1 then [board[0][0], board[1][1], board[2][2]]
  when 2 then [board[0][2], board[1][1], board[2][0]]
  end
end

def winner?(board, marker)
  (0..2).each do |i|
    return true if winner_array?(board[i], marker) # i-th row
    return true if winner_array?(board.transpose[i], marker) # i-th column
  end
  return true if winner_array?(diagonal(board, 1), marker)
  return true if winner_array?(diagonal(board, 2), marker)
  false
end

def round_over?(board)
  check_winner(board) || full?(board)
end

def update_scores!(scores, duel_result)
  case duel_result
  when 1 then scores[:user] += 1
  when -1 then scores[:computer] += 1
  end
end

def display_round_results(winner, scores)
  if winner
    prompt winner.capitalize + " won the round!"
  else
    prompt "It's a tie."
  end
  prompt "Overall score:   Player: #{scores['player']}"
  prompt "               Computer: #{scores['computer']}"
end

# main

loop do
  scores = { "player" => 0, "computer" => 0 }
  loop do
    board = [[INITIAL_MARKER, INITIAL_MARKER, INITIAL_MARKER],
             [INITIAL_MARKER, INITIAL_MARKER, INITIAL_MARKER],
             [INITIAL_MARKER, INITIAL_MARKER, INITIAL_MARKER]]
    loop do
      display(board, scores)
      player_choose_square(board)
      break if round_over?(board)
      computer_choose_square(board)
      break if round_over?(board)
    end
    display(board, scores)
    prompt "Round over"
    winner = check_winner(board)
    scores[winner] += 1 if winner
    display_round_results(winner, scores)
    break if scores.value?(POINTS_TO_WIN)
    prompt "Press enter to start next round"
    gets
  end
  prompt "Game over."
  break unless play_again?
end
prompt "Thanks for playing"
