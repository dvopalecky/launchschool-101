# Rock, Paper, Scissors game

VALID_CHOICES = %w(r p s l k)
FULLNAME_CHOICES = %w((R)ock (P)aper (S)cissors (L)izard Spoc(K))
# -1: loose, 0: tie, 1: win
DUEL_MATRIX = [[0, -1, 1, 1, -1],
               [1, 0, -1, -1, 1],
               [-1, 1, 0, 1, -1],
               [-1, 1, -1, 0, 1],
               [1, -1, 1, -1, 0]]
DUEL_MSG = { -1 => "Computer won", 0 => "Tie", 1 => "You won" }
POINTS_TO_WIN = 5

def prompt(message)
  message.split("\n").each do |line|
    puts "=> #{line}"
  end
end

def clear_screen
  system('clear') || system('cls')
end

def enter_choice
  loop do
    prompt "Choose one: #{FULLNAME_CHOICES.join(', ')}"
    answer = gets.chomp.downcase
    if VALID_CHOICES.include?(answer)
      return VALID_CHOICES.index(answer)
    else
      prompt "Not valid choice."
    end
  end
end

def duel(player_choice, competitor_choice)
  DUEL_MATRIX[player_choice][competitor_choice]
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

def display_new_game
  clear_screen
  prompt "Rock-Paper-Scissor Extended Game"
  prompt "Let's play on #{POINTS_TO_WIN} winning points"
end

def display_game_over(user_score, computer_score)
  if computer_score > user_score
    prompt "\nGame over. Computer won!"
  else
    prompt "\nGame over. You won!"
  end
end

# main
loop do
  display_new_game
  user_score = 0
  computer_score = 0
  loop do # single game loop
    user_choice = enter_choice
    computer_choice = VALID_CHOICES.index(VALID_CHOICES.sample)
    duel_result = duel(user_choice, computer_choice)
    if duel_result == 1 then user_score += 1
    elsif duel_result == -1 then computer_score += 1
    end

    clear_screen
    prompt "You chose:      #{FULLNAME_CHOICES[user_choice]}"
    prompt "Computer chose: #{FULLNAME_CHOICES[computer_choice]}"
    prompt "Round result: #{DUEL_MSG[duel_result]}"
    prompt "Overall score:      You: #{user_score}"
    prompt "               Computer: #{computer_score}"

    break if user_score >= POINTS_TO_WIN || computer_score >= POINTS_TO_WIN
  end
  display_game_over(user_score, computer_score)
  prompt "Do you want to play whole game again? (Y)es or (N)o"
  break unless play_again?
end
prompt "Thank you for playing."
