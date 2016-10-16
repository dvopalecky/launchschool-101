# Rock, Paper, Scissors game

VALID_CHOICES = %w(rock paper scissors)
# -1: loose, 0: tie, 1: win
DUEL_MATRIX = [[0, -1, 1],
               [1, 0, -1],
               [-1, 1, 0]]
DUEL_MSG = { -1 => "Computer won", 0 => "Tie", 1 => "User won" }

def prompt(message)
  puts "=> #{message}"
end

def enter_choice
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    answer = gets.chomp.downcase
    if VALID_CHOICES.include?(answer)
      return answer
    else
      prompt "Not valid choice."
    end
  end
end

def duel(player_choice, competitor_choice)
  player_choice_index = VALID_CHOICES.index(player_choice)
  competitor_choice_index = VALID_CHOICES.index(competitor_choice)
  DUEL_MATRIX[player_choice_index][competitor_choice_index]
end

def play_again?
  loop do
    answer = gets.chomp
    if answer.casecmp("y").zero?
      return true
    elsif answer.casecmp("n").zero?
      return false
    else
      prompt "Please enter Y or N"
    end
  end
end

# main
prompt "RPS Game"
loop do
  loop do # single game loop
    user_choice = enter_choice
    computer_choice = VALID_CHOICES.sample

    duel_result = duel(user_choice, computer_choice)
    prompt "You chose: #{user_choice}, computer chose: #{computer_choice}"
    prompt DUEL_MSG[duel_result]

    if duel_result.nonzero?
      break
    else
      prompt "Let's play again."
    end
  end
  prompt "Do you want to play again? (Y)es or (N)o"
  break unless play_again?
end
prompt "Thank you for playing."
