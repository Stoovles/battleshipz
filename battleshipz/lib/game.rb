require 'pry'
# require './lib/board'

def initialize

end

def start
  main_menu
end

def main_menu #also needs this option at end of game
  puts "Welcome to Battleshipz!"
  puts "Enter p to play. Enter q to quit."
  puts "> "
  play_or_quit = gets.chomp
  if play_or_quit == "q"
    exit
  else
    play_game
  end
end

def play_game
  # computer ship placement
  puts "I have laid out my ships on the board."
  puts "Now it's your turn."
  puts "The cruiser is three coordinates long and the submarine is two."
  put "empty board render"
  puts "Enter three consecutive coordinates for the cruiser:"
  puts "> "
  # playership placement
end

def game_over
  main_menu
end


# def start
#   puts "Welcome! You're playing with #{@deck.count} cards."
#   puts "-------------------------------------------------"
#   play_game
#   game_over
# end


# def play_game
#   @deck.cards.each do |card|
#     puts "This is card number #{@current_card_index + 1} out of #{@deck.count}."
#     puts "Question: #{current_card.question}"
#     guess = gets.chomp
#     turn = take_turn(guess)
#     puts turn.feedback
#     puts "-------------------------------------------------"
#   end
# end
#
# def game_over
#   puts "****** Game over! ******"
#   puts "You had #{number_correct} correct guesses out of #{@turns.count} for a total score of #{percent_correct}%."
#   @deck.card_categories.each do |category|
#     puts "#{category}: #{percent_correct_by_category(category)}% correct."
#   end
# end
