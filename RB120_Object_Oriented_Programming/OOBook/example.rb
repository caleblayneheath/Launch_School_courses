

module Genes
  def show_ancestry(a_class)
    puts a_class.ancestors
  end
end

class Card
  include Genes
end

Card.new.show_ancestry(Card)