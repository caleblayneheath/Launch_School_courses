class Game
  GOAL_NUMBER = 21

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @winner = nil
  end

  def play
    clear
    display_welcome_message
    loop do
      deal_cards
      display_cards
      player_turn
      dealer_turn unless player.busted?
      compare_points
      show_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  attr_reader :player, :dealer
  attr_accessor :winner, :deck

  def clear
    system('clear')
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
    puts
  end

  def deal_cards
    deck.deal(player, 2)
    deck.deal(dealer, 2)
    dealer.hide_first_card
  end

  def display_cards
    player.show_hand
    dealer.show_hand
    puts
  end

  def player_turn
    loop do
      player.choose(deck)

      clear_screen_and_display_cards
      handle_busts(player, dealer)

      break if player.stay? || player.busted?
    end
  end

  def dealer_turn
    loop do
      dealer.stay if dealer.at_limit?
      break if dealer.stay? || dealer.busted?

      dealer.hit(deck)

      clear_screen_and_display_cards
      handle_busts(dealer, player)
    end
  end

  def handle_busts(active, inactive)
    return unless active.busted?
    self.winner = inactive
    display_busted(active.name)
  end

  def display_busted(name)
    puts "#{name} busted!"
    puts
  end

  def compare_points
    return if winner

    self.winner = if player > dealer
                    player
                  elsif dealer > player
                    dealer
                  end
  end

  def show_result
    if winner
      puts "The winner is #{winner.name}"
    else
      puts "It's a tie!"
    end
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def display_goodbye_message
    puts
    puts "Thanks for playing. Goodbye!"
  end

  def clear_screen_and_display_cards
    clear
    display_cards
  end

  def reset
    player.reset
    dealer.reset
    self.winner = nil
    self.deck = Deck.new
    clear
  end
end

module Hand
  include Comparable

  attr_reader :hand

  def show_hand
    puts "#{name} has: #{hand.join(', ')}"
  end

  def hit(deck)
    deck.deal(self)
    total
  end

  def total
    working_total = 0
    hand.each do |card|
      working_total += assign_points(card)
    end
    working_total = correct_for_aces(working_total)
    @point_total = working_total
  end

  def stay
    @stay = true
  end

  def stay?
    @stay
  end

  def busted?
    @point_total > Game::GOAL_NUMBER
  end

  def <=>(other_player)
    point_total <=> other_player.point_total
  end

  private

  def assign_points(card)
    if card.jack? || card.queen? || card.king?
      10
    elsif card.ace?
      11
    else
      card.value.to_i
    end
  end

  def correct_for_aces(working_total)
    number_of_aces = hand.select(&:ace?).size
    number_of_aces.times do
      break if working_total <= Game::GOAL_NUMBER
      working_total -= 10 if working_total > Game::GOAL_NUMBER
    end
    working_total
  end
end

class Participant
  include Hand

  attr_reader :name, :point_total

  def initialize
    reset
  end

  def reset
    @hand = []
    @point_total = 0
    @stay = false
  end
end

class Player < Participant
  def initialize
    super
    @name = set_name
  end

  def choose(deck)
    input = nil
    loop do
      puts
      puts "Type 'h' to hit or 's' to stay."
      input = gets.chomp.downcase
      break if ['h', 's'].include?(input)
      puts 'Invalid entry.'
    end

    if input == 'h'
      hit(deck)
    elsif input == 's'
      stay
    end
  end

  private

  def set_name
    input = nil
    loop do
      puts "Please enter your name."
      input = gets.chomp
      break unless input.strip.empty?
      puts "Empty strings are not valid."
    end
    input
  end
end

class Dealer < Participant
  STAY_UNLESS_POINTS = 17

  NAMES = %w(Chappie Bishop Threepeeo)

  def initialize
    super
    @name = set_name
  end

  def at_limit?
    total
    @point_total >= STAY_UNLESS_POINTS
  end

  def hide_first_card
    hand.first.hide_card
  end

  private

  def set_name
    NAMES.sample
  end
end

class Deck
  def initialize
    @deck = create_shuffled_deck
  end

  def deal(participant, number = 1)
    number.times { participant.hand << deck.pop }
  end

  private

  attr_reader :deck

  def create_shuffled_deck
    deck = []
    all_cards = Card::SUITS.product(Card::VALUES)
    all_cards.each do |suit, value|
      deck << Card.new(suit, value)
    end
    deck.shuffle
  end
end

class Card
  SUITS = %w(Hearts Clubs Spades Diamonds)
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack King Queen Ace)

  attr_reader :value

  def initialize(suit, value)
    @suit = suit
    @value = value
    @hidden = false
  end

  def to_s
    hidden? ? 'Unknown card' : "#{value} of #{suit}"
  end

  def hide_card
    @hidden = true
  end

  def jack?
    value == 'Jack'
  end

  def queen?
    value == 'Queen'
  end

  def king?
    value == 'King'
  end

  def ace?
    value == 'Acd'
  end

  private

  attr_reader :suit, :hidden

  def hidden?
    hidden
  end
end

Game.new.play
