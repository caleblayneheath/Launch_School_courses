require 'pry-byebug'

class Game
  GOAL_NUMBER = 21

  attr_reader :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @winner = nil
  end

  def start
    clear
    display_welcome_message
    deal_cards
    display_cards
    player_turn
    dealer_turn unless player.busted?
    compare_points
    show_result
    display_goodbye_message
  end

  private

  attr_reader :player, :dealer, :winner

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
    dealer.hand.first.hide_card
  end

  def display_cards
    player.show_hand
    dealer.show_hand
    puts
  end

  def player_turn
    loop do
      input = player.choose

      case input
      when 'h' then player.hit(deck)
      when 's' then player.stay
      end
      clear
      player.total
      display_cards

      if player.busted?
        @winner = dealer
        puts "#{name} busted!"
        puts
        break
      end

      break if player.stay?
    end
  end

  def dealer_turn
    dealer.total
    loop do
      dealer.stay if dealer.at_limit?
      dealer.stay? ? break : dealer.hit(deck)
      clear
      display_cards

      dealer.total

      if dealer.busted?
        clear
        display_cards
        @winner = player
        puts "#{dealer.name} busted!"
        puts
        break
      end
    end
  end

  def compare_points
    return if winner

    @winner = if player > dealer
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
  end

  def display_goodbye_message
    puts
    puts "Thanks for playing. Goodbye!"
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
  end

  def stay
    @stay = true
  end

  def stay?
    @stay
  end

  def total
    working_total = 0
    hand.each do |card|
      working_total += assign_points(card.value)
    end
    working_total = correct_for_aces(working_total)
    @point_total = working_total
  end

  def busted?
    @point_total > Game::GOAL_NUMBER
  end

  def <=>(other_player)
    point_total <=> other_player.point_total
  end

  private

  def assign_points(value)
    if (2..10).cover?(value.to_i)
      value.to_i
    elsif value == 'Jack'
      10
    elsif value == 'Queen'
      10
    elsif value == 'King'
      10
    elsif value == 'Ace'
      11
    end
  end

  def correct_for_aces(working_total)
    number_of_aces = hand.select { |card| card.value == 'Ace' }.size
    number_of_aces.times do
      break if working_total <= Game::GOAL_NUMBER
      working_total -= 10 if working_total > Game::GOAL_NUMBER
    end
    working_total
  end
end

class Player
  include Hand

  attr_reader :name, :point_total

  def initialize
    @name = 'Player'
    @hand = []
    @point_total = 0
  end

  def choose
    input = nil
    loop do
      puts
      puts "Type 'h' to hit or 's' to stay."
      input = gets.chomp.downcase
      break if ['h', 's'].include?(input)
      puts 'Invalid entry.'
    end
    input
  end
end

class Dealer
  include Hand

  attr_reader :name, :point_total

  def initialize
    @name = 'Dealer'
    @hand = []
    @point_total = 0
  end

  def at_limit?
    @point_total >= 17
  end
end

class Deck
  SUITS = %w(Hearts Clubs Spades Diamonds)
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack King Queen Ace)

  def initialize
    @deck = create_deck
  end

  def deal(participant, number = 1)
    number.times { participant.hand << deck.pop }
  end

  private

  attr_reader :deck

  def create_deck
    deck = []
    all_cards = SUITS.product(VALUES)
    all_cards.each do |suit, value|
      deck << Card.new(suit, value)
    end
    deck.shuffle
  end
end

class Card
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

  private

  attr_reader :suit, :hidden

  def hidden?
    hidden
  end
end

Game.new.start
