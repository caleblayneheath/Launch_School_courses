require 'pry'
require 'pry-byebug'

SUITS = %w(C D H S)
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10,
                'K' => 10, 'A' => 11 }

STARTING_DECK = SUITS.flat_map do |suit|
  cards = []
  CARD_VALUES.to_a.each { |string, number| cards << [suit, string, number] }
  cards
end

DEALER_GOAL = 17
GOAL_NUMBER = 21

def prompt(string)
  puts "=> #{string}"
end

def initialize_deck
  STARTING_DECK.dup.shuffle
end

def initialize_player
  { cards: [], total: 0 }
end

def deal_cards(player, deck, number = 1)
  number.times do
    dealt_card = deck.pop
    player[:cards] << dealt_card
    total_hand(player)
    if !!player[:cards].rassoc('A')
      assign_ace_value(player)
    end
  end
end

def assign_ace_value(player)
  if (player[:total]) > GOAL_NUMBER
    player[:cards].each do |card|
      if card[-1] == 11
        card[-1] = 1
        total_hand(player)
      end
      break if player[:total] <= GOAL_NUMBER
    end
  end
end

def initial_deal(player, dealer, deck)
  deal_cards(player, deck, 2)
  deal_cards(dealer, deck, 2)
end

def total_hand(player)
  player[:total] = player[:cards].sum(&:last)
end

def show_hands(player_hand, dealer_hand)
  prompt("Dealer has: #{format_cards(dealer_hand, 'hide')}")
  prompt("You have: #{format_cards(player_hand)}.")
end

def show_player_total(total)
  prompt("Your total is #{total}.")
end

def format_cards(cards, hide = nil)
  show = cards.map { |_, value, _| value }
  if hide == 'hide'
    show[0] = 'Unknown card'
  end
  show.join(', ')
end

def busted?(total)
  total > GOAL_NUMBER
end

def compare_totals(player, dealer)
  return 'dealer' if player[:total] < dealer[:total]
  'player'
end

def invalid_choice
  prompt 'Invalid selection.'
end


# setup game
game_deck = initialize_deck
winner = nil

# { cards: hand, total: value_of_hand}
player = initialize_player
dealer = initialize_player

initial_deal(player, dealer, game_deck)
show_hands(player[:cards], dealer[:cards])
show_player_total(player[:total])

# player turn
loop do
  prompt("Enter 'd' to draw a card, or 's' to stay")
  choice = gets.chomp.downcase
  puts

  unless ['d', 's'].include?(choice)
    invalid_choice
    continue
  end

  if choice == 'd'
    deal_cards(player, game_deck)
  end

  show_hands(player[:cards], dealer[:cards])
  show_player_total(player[:total])
  

  if busted?(player[:total])
    winner = 'dealer'
    prompt("You busted!")
    break
  end

  if choice == 's'
    break
  end

end

# dealer turn
unless winner == 'dealer'
  loop do
    puts
    if dealer[:total] <= DEALER_GOAL
      deal_cards(dealer, game_deck)
      show_hands(player[:cards], dealer[:cards])
    else
      break
    end

    if busted?(dealer[:total])
      winner = 'player'
      prompt("Dealer busted!")
    end
  end
end

if winner.nil?
  winner = compare_totals(player, dealer)
end

prompt("The winner is #{winner}.")
