CARD_NAMES = %w(2 3 4 5 6 7 8 9 10 jack queen king ace).freeze
CARD_SUITS = %w(hearts diamonds clubs spades).freeze
CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, :ace].freeze

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts "=> " + message
end

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
  card_db
end

def initialize_holders
  holders = { deck: [], player: [], dealer: [] }
  52.times { |i| holders[:deck].push(i) }
  holders[:deck].shuffle!
  holders
end

def show_hand(holders, holder)
  holders[holder]
end

def remaining_cards(holders)
  holders[:deck]
end

def draw_card!(holders, who_draws)
  card_id = holders[:deck].pop
  holders[who_draws].push(card_id)
end

def deal_initial_cards!(holders)
  2.times do
    draw_card!(holders, :player)
    draw_card!(holders, :dealer)
  end
end

def add_spaces(string, total_length)
  nb_spaces = [0, total_length - string.size].max
  string + " " * nb_spaces
end

def display_card(card_id, card_db)
  info = card_db[card_id]
  value = info[:value]
  value = "1 or 11" if value == :ace
  prompt "  #{add_spaces(info[:name].capitalize, 5)} of "\
       "#{add_spaces(info[:suit].capitalize, 8)} | Value: #{value}"
end

def display_cards(holders, card_db, game_over = false)
  clear_screen
  prompt "Player cards:"
  holders[:player].each { |id| display_card(id, card_db) }
  prompt "Dealer cards:"
  if game_over
    holders[:dealer].each { |id| display_card(id, card_db) }
  else
    display_card(holders[:dealer].first, card_db)
    prompt "  ** Hidden card **"
  end
end

def display_cards_value(value, name)
  prompt "Value of #{name}'s cards: #{value}#{' BUSTED' if value > 21}"
end

def display_round_results(values, dealer_drew_count)
  display_cards_value(values[:player], "player")
  display_cards_value(values[:dealer], "dealer")
  if values[:player]
    prompt "Busted. You LOOSE."
  else
    prompt "You stayed. Dealer drew #{dealer_drew_count} extra card"\
           "#{'s' if dealer_drew_count == 1}."
    if values[:player] > values[:dealer]
      prompt "You WIN. Player's cards' value is higher."
    elsif values[:dealer] > 21
      prompt "You WIN. Dealer busted."
    elsif values[:player] == values[:dealer]
      prompt "It's a TIE."
    else
      prompt "You LOOSE. Dealer's cards' value is higher."
    end
  end
  prompt "Round over."
end

def values(holders, card_db)
  hash = {}
  hash[:player] = hand_value(:player, holders, card_db)
  hash[:dealer] = hand_value(:dealer, holders, card_db)
  hash
end

def hand_value(holder, holders, card_db)
  sum = 0
  nb_aces = 0
  holders[holder].each do |card_id|
    value = card_db[card_id][:value]
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

def busted?(holder, holders, card_db)
  hand_value(holder, holders, card_db) > 21
end

def enter_hit_or_stay
  loop do
    prompt "(H)it or (S)tay?"
    answer = gets.chomp.downcase
    return answer if %w(h s).include?(answer)
  end
end

def dealers_turn!(holders, card_db)
  while hand_value(:dealer, holders, card_db) < 17
    draw_card!(holders, :dealer)
  end
end

# main
card_db = initialize_card_db
holders = initialize_holders
deal_initial_cards!(holders)

loop do # round loop
  display_cards(holders, card_db)
  break if busted?(:player, holders, card_db)
  p hit_or_stay = enter_hit_or_stay
  if hit_or_stay == "s"
    dealers_turn!(holders, card_db)
    break
  end
  prompt "Hitting..."
  draw_card!(holders, :player)
end

display_cards(holders, card_db, true)
values = values(holders, card_db)
dealer_drew_count = holders[:dealer].count - 2
display_round_results(values, dealer_drew_count)
