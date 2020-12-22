A = File.read("aoc_2020_22.txt")

def score(winner)
  k = winner.length
  score = 0
  winner.each do |n|
    score += k*n
    k -= 1
  end 
  score
end  

player1, player2 = A.split("\n\n")
player1_cards = player1.split("\n")[1..-1].map(&:to_i)
player2_cards = player2.split("\n")[1..-1].map(&:to_i)

until !(player1_cards.any? || player2_cards.any?)
  i = player1_cards[0]
  j = player2_cards[0]
  break unless i && j
  player1_cards.shift
  player2_cards.shift
  if i > j
    player1_cards << i << j
  else
    player2_cards << j << i
  end
end

winner = [player1_cards, player2_cards].find {|a| a.any?}
p score(winner)

# 2
require 'set'

player1_cards = player1.split("\n")[1..-1].map(&:to_i)
player2_cards = player2.split("\n")[1..-1].map(&:to_i)

@player1_cards = []
@player2_cards = []

def recurse(player1_cards, player2_cards)
  prev_rounds1 = Set.new
  prev_rounds2 = Set.new
  until !(player1_cards.any? || player2_cards.any?)
    if prev_rounds1.include?(player1_cards) && prev_rounds2.include?(player2_cards)
      return 1
    end
    i = player1_cards[0]
    j = player2_cards[0]
    @player1_cards = player1_cards
    @player2_cards = player2_cards
    break unless i && j
    prev_rounds1 << player1_cards
    prev_rounds2 << player2_cards 
    if i < player1_cards.length && j < player2_cards.length
      player1_cards.shift
      player2_cards.shift
      winner = recurse(player1_cards.clone[0..i-1], player2_cards.clone[0..j-1]) 
      if winner == 1
        player1_cards << i << j
      else
        player2_cards << j << i
      end
    else  
      player1_cards.shift
      player2_cards.shift 
      if i > j
        player1_cards << i << j
      else
        player2_cards << j << i
      end
    end 
  end
  return player1_cards.any? ? 1 : 2
end  

recurse(player1_cards, player2_cards)
winner = @player1_cards.any? ? @player1_cards : @player2_cards

p score(winner)
