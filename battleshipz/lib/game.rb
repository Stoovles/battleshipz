require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/computer_player'

class Game

  def start
    main_menu
    board_setup
    human_place_cruiser
    human_place_submarine
    # computer_ship_placement
  end

  def main_menu #also needs this option at end of game
    puts "Welcome to Battleshipz!"
    puts "Enter p to play. Enter q to quit."
    print "> "
    play_or_quit = gets.chomp
    if play_or_quit == "q"
      exit
    end
  end

  def board_setup
    puts "The game board is a grid. Choose a number for the x axis."
    print "> "
    x_axis_length = gets.chomp.to_i
    puts "Now choose a number for the y axis."
    print "> "
    y_axis_width = gets.chomp.to_i
    @board = Board.new(y_axis_width, x_axis_length)
    puts @board.render
  end
    # computer_ship_placement
    # puts "I have laid out my ships on the board."
    # puts "Now it's your turn."
  def human_place_cruiser
    puts "The cruiser is three coordinates long and the submarine is two."
    puts "Enter three consecutive coordinates for the cruiser:"
    print "> "
    human_cruiser_coordinates = gets.chomp.split
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, human_cruiser_coordinates)
    puts @board.render(true)
  end

  def human_place_submarine
    puts "Enter two consecutive coordinates for the submarine:"
    print "> "
    human_sub_coordinates = gets.chomp.split
    submarine = Ship.new("Submarine", 2)
    if @board.place(submarine, human_sub_coordinates) == false
      human_place_submarine
    end
    puts @board.render(true)

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
end
