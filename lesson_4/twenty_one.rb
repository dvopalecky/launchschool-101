# Twenty-one game
# Credits: card ascii taken from hjw from http://ascii.co.uk/art/cards 
CARD_NAMES = %w(2 3 4 5 6 7 8 9 X J Q K A).freeze
CARD_SUITS = %w(hearts diamonds clubs spades).freeze
CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, :ace].freeze
CARD_ASCII = [".------. .------. .------. .------. .------.",
              "|A_  _ | |A /\\  | |A _   | |A .   | |A     | ",
              "|( \\/ )| | /  \\ | | ( )  | | / \\  | |      | ",
              "| \\  / | | \\  / | |(_x_) | |(_,_) | |      | ",
              "|  \\/ A| |  \\/ A| |  Y  A| |  I  A| |     A| ",
              "`------' `------' `------' `------' `------' "].freeze
POINTS_TO_WIN = 3
BUSTED_THRESHOLD = 21
DEALER_THRESHOLD = 17

def initialize_card_db
  # card_db is hash with key = 0..51 and where
  # value is another hash with keys :suit :name and :value
  card_db = {}
  card_id = 0
  CARD_SUITS.each do |suit|
    CARD_NAMES.each_with_index do |name, index|
      card_db[card_id] = { suit: suit, name: name, value: CARD_VALUES[index] }
      card_id += 1
    end
  end
  card_db[:hidden] = { suit: "hidden", name: "?", value: 0 }
  card_db
end

CARD_DB = initialize_card_db

def clear_screen
  system('clear') || system('cls')
end

def prompt(message = "")
  puts "=> " + message
end

def add_spaces(string, total_length)
  nb_spaces = [0, total_length - string.size].max
  string + " " * nb_spaces
end

def display_welcome
  clear_screen
  prompt "Welcome to Game of #{BUSTED_THRESHOLD}"
  prompt "Let's play to #{POINTS_TO_WIN} winning points"
  prompt "Press enter to start"
  gets
end

def display_scores_cards_message(scores, holders, message, round_over = false)
  clear_screen
  display_scores(scores)
  display_cards(holders, round_over)
  prompt "Last action(s): #{message}" if message
end

def display_scores(scores)
  prompt "Overall score: #{scores[:player]} : #{scores[:dealer]} " \
       "(Player : Dealer)"
end

def display_cards(holders, round_over = false)
  prompt "Player cards: " + display_total(holders[:player])
  display_cards_ascii(holders[:player])
  if round_over
    prompt "Dealer cards: " + display_total(holders[:dealer])
    display_cards_ascii(holders[:dealer])
  else
    prompt "Dealer cards: (Total: Unknown)"
    display_cards_ascii([holders[:dealer].first, :hidden])
  end
end

def display_total(holder)
  total = total(holder)
  "(Total: #{total}#{' BUSTED' if total > BUSTED_THRESHOLD})"
end

def display_round_results(result)
  prompt
  prompt "Round Results: " +
         case result
         when :player_busted then "You busted. You LOOSE."
         when :dealer_busted then "You WIN. Dealer busted."
         when :player then "You WIN. Your total is higher."
         when :dealer then "You LOOSE. Dealer's total is higher."
         when :tie then "It's a TIE."
         end
  prompt
end

def display_game_over(scores)
  game_result = scores[:player] > scores[:dealer] ? "You won :)" : "You lost :("
  prompt "Game over. " + game_result
end

def single_card_ascii(card_id)
  offset = case CARD_DB[card_id][:suit]
           when "hearts" then 0
           when "diamonds" then 9
           when "clubs" then 18
           when "spades" then 27
           when "hidden" then 36
           end
  single_card_ascii = CARD_ASCII.map { |v| v[offset, 9] }.join("\n")
  single_card_ascii.gsub!("A", CARD_DB[card_id][:name])
end

def append_ascii_card(str1, str2)
  str1_lines = str1.split("\n")
  str2_lines = str2.split("\n")
  str1_lines.each_with_index do |line, index|
    line << str2_lines[index]
  end
  str1_lines.join("\n")
end

def display_cards_ascii(cards_ids)
  output = " \n" * 6
  cards_ids.each do |card_id|
    output = append_ascii_card(output, single_card_ascii(card_id))
  end
  puts output
end

def initialize_holders
  holders = { deck: [], player: [], dealer: [] }
  52.times { |i| holders[:deck].push(i) }
  holders[:deck].shuffle!
  holders
end

def deal_initial_cards!(holders)
  2.times do
    draw_card!(holders, :player)
    draw_card!(holders, :dealer)
  end
end

def draw_card!(holders, who_draws)
  card_id = holders[:deck].pop
  holders[who_draws].push(card_id)
end

def totals(holders)
  hash = {}
  hash[:player] = total(holders[:player])
  hash[:dealer] = total(holders[:dealer])
  hash
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

def total(holder)
  sum = 0
  nb_aces = 0
  holder.each do |card_id|
    value = CARD_DB[card_id][:value]
    if value == :ace
      value = 1
      nb_aces += 1
    end
    sum += value
  end
  nb_aces.times do
    break if sum > 11
    sum += 10
  end
  sum
end

def busted?(holder)
  total(holder) > BUSTED_THRESHOLD
end

def enter_hit_or_stay
  loop do
    prompt "(H)it or (S)tay?"
    answer = gets.chomp.downcase
    return answer if %w(h s).include?(answer)
  end
end

def dealers_turn!(holders)
  while total(holders[:dealer]) < DEALER_THRESHOLD
    draw_card!(holders, :dealer)
  end
end

def detect_result(holders)
  totals = totals(holders)
  if totals[:player] > BUSTED_THRESHOLD
    :player_busted
  elsif totals[:dealer] > BUSTED_THRESHOLD
    :dealer_busted
  elsif totals[:player] > totals[:dealer]
    :player
  elsif totals[:player] == totals[:dealer]
    :tie
  else
    :dealer
  end
end

def update_scores!(scores, result)
  case result
  when :player_busted, :dealer then scores[:dealer] += 1
  when :dealer_busted, :player then scores[:player] += 1
  end
end

# main
display_welcome
loop do # game loop
  scores = { player: 0, dealer: 0 }
  loop do
    holders = initialize_holders
    deal_initial_cards!(holders)
    message = nil
    loop do # inner round loop
      display_scores_cards_message(scores, holders, message)
      break if busted?(holders[:player])
      if enter_hit_or_stay == "s"
        dealers_turn!(holders)
        dealer_drew_count = holders[:dealer].count - 2
        message = "You stayed. Dealer drew #{dealer_drew_count} extra card"\
                  "#{'s' unless dealer_drew_count == 1}."
        break
      end
      draw_card!(holders, :player)
      message = "You hitted."
    end
    round_result = detect_result(holders)
    update_scores!(scores, round_result)
    display_scores_cards_message(scores, holders, message, true)
    display_round_results(round_result)
    break if scores.value?(POINTS_TO_WIN)
    prompt "Press enter to start next round"
    gets
  end
  display_game_over(scores)
  break unless play_again?
end
prompt "Thanks for playing"
