# Rock, Paper, Scissors, Lizard, Spock game

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
  prompt "Do you want to play whole game again? (Y)es or (N)o"
  loop do
    case gets.chomp
    when "y", "Y" then return true
    when "n", "N" then return false
    else prompt "Please enter Y or N"
    end
  end
end

def display_new_game
  clear_screen
  prompt "Rock-Paper-Scissor Extended Game"
  prompt "Let's play on #{POINTS_TO_WIN} winning points"
end

def display_game_over(scores)
  if scores[:computer] > scores[:user]
    prompt "\nGame over. Computer won!"
  else
    prompt "\nGame over. You won!"
  end
end

def display_results(choices, duel_result, scores)
  clear_screen
  prompt "You chose:      #{FULLNAME_CHOICES[choices[:user]]}"
  prompt "Computer chose: #{FULLNAME_CHOICES[choices[:computer]]}"
  prompt "Round result: #{DUEL_MSG[duel_result]}"
  prompt "Overall score:      You: #{scores[:user]}"
  prompt "               Computer: #{scores[:computer]}"
end

def update_scores!(scores, duel_result)
  case duel_result
  when 1 then scores[:user] += 1
  when -1 then scores[:computer] += 1
  end
end

# main
loop do
  display_new_game
  scores = { user: 0, computer: 0 }
  loop do # single game loop
    choices = {}
    choices[:user] = enter_choice
    choices[:computer] = VALID_CHOICES.index(VALID_CHOICES.sample)
    duel_result = duel(choices[:user], choices[:computer])
    update_scores!(scores, duel_result)
    display_results(choices, duel_result, scores)
    break if scores.value?(POINTS_TO_WIN)
  end
  display_game_over(scores)
  break unless play_again?
end
prompt "Thank you for playing."
