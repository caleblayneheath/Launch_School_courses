require 'pry-byebug'

class Game  
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
    dealer_turn
    show_result
    display_goodbye_message
  end

  private

  attr_reader :player, :dealer, :deck, :winner

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
  end

  def display_cards
    player.show_hand
    dealer.show_hand
  end

  def player_turn
    # hit or stay
    # if hit
    #   draw card
    #   calculate hand total
    #   check for busted
    #   if busted?
    #     declare dealer winner
    # if stay
    #  break
    loop do
      input = get_player_input
     
      case input
      when 'h' then player.hit(deck)
      when 's' then player.stay
      end
      
      if player.busted?
        @winner = dealer 
        break
      end

      break if player.stay?
    end
    puts player.hand
    puts player.point_total
  end

  def get_player_input
    input = nil
    loop do
      puts "Type 'h' to hit or 's' to stay."
      input = gets.chomp.downcase
      break if ['h', 's'].include?(input)
      puts 'Invalid entry.'
    end
    input
  end

  def dealer_turn
  end

  def show_result
    return unless winner
    puts "The winner is #{winner.name}"
  end

  def display_goodbye_message
    puts
    puts "Thanks for playing Goodbye!"
  end
end

module Hand
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
    working_total = nil
    hand.each do |card|
      working_total += assign_points(card.value)
    end
    @point_total = working_total
  end

  def assign_points(card_value)
    if (2..10).include?(value.to_i)
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

  def busted?
  end
end

class Player
  include Hand
  
  attr_reader :name, :hand, :point_total

  def initialize
    #states: hand (of cards), point total of hand, name?
    #busted or not
    @name = 'Player'
    @hand = []
    @point_total = nil
  end
end

class Dealer
  include Hand
  
  attr_reader :name, :hand

  def initialize
    #states: hand (of cards), point total of hand, name?
    #busted or not
    @name = 'Dealer'
    @hand = []
  end
end

class Deck
  SUITS = %w(Hearts Clubs Spades Diamonds)
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack King Queen Ace)

  def initialize
    #states: deck of cards (array of card objects/structs)
    @deck = create_deck
  end
  
  def to_s
    # deck.map(&:to_s)
    # deck.size
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

  def shuffle
  end
end

class Card
  def initialize(suit, value)
    @suit = suit
    @value = value
    # @points = assign_points
    @hidden = false
  end

  def to_s
    hidden? ? 'Unknown' : "#{value} of #{suit}"
  end

  private

  attr_reader :value, :suit, :hidden

  def hidden?
    hidden
  end
end

Game.new.start