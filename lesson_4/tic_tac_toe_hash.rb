# Tic Tac Toe Game
require 'pry'

INITIAL_MARKER = " ".freeze
PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
DASHED_ROW = "+-----" * 3 + "+"
EMPTY_ROW = "|     " * 3 + "|"
POINTS_TO_WIN = 3
LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
         [1, 4, 7], [2, 5, 8], [3, 6, 9],
         [1, 5, 9], [3, 5, 7]].freeze
PLAYERS = ["player", "computer"].freeze

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
  board.values.each_slice(3) do |row|
    puts EMPTY_ROW
    puts "|  " + row.join("  |  ") + "  |"
    puts EMPTY_ROW
    puts DASHED_ROW
  end
end

def full?(board)
  !board.values.include?(INITIAL_MARKER)
end

def enter_value_in_range(range)
  loop do
    answer = gets.chomp
    return answer if range.include?(answer)
    prompt "Please enter value between #{range.first} and #{range.last}"
  end
end

def player_choose_square(board)
  if empty_squares(board).size == 1
    mark!(board, PLAYER_MARKER, empty_squares(board).first)
  else
    loop do
      prompt "Enter square (1 ... 9)"
      answer = enter_value_in_range("1".."9").to_i
      break if mark!(board, PLAYER_MARKER, answer)
      prompt "Square is already filled"
    end
  end
end

def find_winning_square(board, offensive_marker)
  LINES.each do |line| # try to win in 1 move
    next unless count_markers_on_line(board, line, offensive_marker) == 2
    selected = board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }
    square = selected.keys.first
    return square unless square.nil?
  end
  nil
end

def computer_choose_square(board)
  square = find_winning_square(board, COMPUTER_MARKER) # offense
  square = find_winning_square(board, PLAYER_MARKER) if !square # defense
  square = 5 if !square && empty_squares(board).include?(5)
  square = empty_squares(board).sample if !square # chose random
  mark!(board, COMPUTER_MARKER, square)
end

def count_markers_on_line(board, line, marker)
  board.values_at(*line).count(marker)
end

def empty_squares(board)
  board.select { |_, v| v == INITIAL_MARKER }.keys
end

def mark!(board, input, position)
  if board[position] == INITIAL_MARKER
    board[position] = input
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
  nil
end

def winner?(board, marker)
  LINES.any? { |line| count_markers_on_line(board, line, marker) == 3 }
end

def round_over?(board)
  check_winner(board) || full?(board)
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

def who_starts_next_round(who_starts, winner)
  if winner
    alternate_player(winner)
  else
    alternate_player(who_starts) # switch first move
  end
end

def choose_square!(board, current_player)
  if current_player == "computer"
    computer_choose_square(board)
  else
    player_choose_square(board)
  end
end

def alternate_player(current_player)
  current_player == "player" ? "computer" : "player"
end

def initialize_board
  board = {}
  9.times { |i| board[i + 1] = INITIAL_MARKER }
  board
end

def play_round(who_starts, scores)
  current_player = who_starts
  board = initialize_board
  loop do
    display(board, scores) if current_player == "player"
    choose_square!(board, current_player)
    current_player = alternate_player(current_player)
    break if round_over?(board)
  end
  display(board, scores)
  prompt "Round over"
  check_winner(board)
end

def update_scores!(scores, winner)
  scores[winner] += 1 if winner
end

def game_over?(scores)
  scores.value?(POINTS_TO_WIN)
end

# main
loop do # game
  scores = { "player" => 0, "computer" => 0 }
  who_starts = PLAYERS.sample
  loop do # round
    winner = play_round(who_starts, scores)
    update_scores!(scores, winner)
    who_starts = who_starts_next_round(who_starts, winner)
    display_round_results(winner, scores)
    break if game_over?(scores)
    prompt "Press enter to start next round"
    gets
  end
  prompt "Game over."
  break unless play_again?
end
prompt "Thanks for playing"
