require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer_player'

class Game

attr_reader :rows, :columns, :computer_board, :player_board,
            :computer_submarine, :computer_cruiser,
            :player_submarine, :player_cruiser

  def initialize
    @rows = 4
    @columns = 4
    @@computer_board = {}
    @player_board = {}
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
  end

  def start
    continue = 1
    while continue == 1
      puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
      decision = gets.chomp
      if decision == "q"
        abort("Well fine, I didn't want to play with you anyway!")
      elsif decision == "p"
        continue = 0
        game_start
      else
        puts "Let's try that again..."
      end
    end
  end

  def game_start
    puts "Please determine the size of your board!"
    puts "Enter how many rows you would like:"
    @rows = gets.chomp.to_i
    puts "Enter how many columns you would like:"
    @columns = gets.chomp.to_i
    computer_start


  end

  def computer_start
    @computer_board = Board.new(@rows, @columns)
    @computer_board.board_hash
    computer_player = ComputerPlayer.new

    random_cell = computer_player.choose_random_cell(@computer_board)
    submarine_coordinates = computer_player.choose_random_cells_placement_submarine(@computer_board, random_cell)
    @computer_board.place(@computer_submarine, submarine_coordinates)

    random_cell = computer_player.choose_random_cell(@computer_board)
    cruiser_coordinates = computer_player.choose_random_cells_placement_cruiser(@computer_board, random_cell)
    @computer_board.place(@computer_cruiser, cruiser_coordinates)
    player_start
  end

  def player_start
    @player_board = Board.new(@rows, @columns)
    @player_board.board_hash
    puts "Hello Hooman, my name is Rob. I will be your opponent."
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."

    puts @player_board.render(true)

    continue = 0
    while continue == 0
      puts "Enter the squares for the Cruiser (3 spaces):"
      cruiser_coordinates = gets.chomp
      cruiser_coordinates = cruiser_coordinates.split
      if @player_board.valid_placement?(@player_cruiser, cruiser_coordinates)
        @player_board.place(@player_cruiser, cruiser_coordinates)
        puts @player_board.render(true)
        continue = 1
      else
        puts "Those are invalid coordinates."
      end
    end
    continue = 0
    while continue == 0
      puts "Enter the squares for the Submarine (2 Spaces):"
      submarine_coordinates = gets.chomp
      submarine_coordinates = submarine_coordinates.split
      if @player_board.valid_placement?(@player_submarine, submarine_coordinates)
        @player_board.place(@player_submarine, submarine_coordinates)
        puts @player_board.render(true)
        continue = 1
      else
        puts "Those are invalid coordinates."
      end
    end
    turn_start
  end

  def turn_start
    until game_over
      puts "=================COMPUTER BOARD================="
      puts @computer_board.render
      puts "=================PLAYER BOARD==================="
      puts @player_board.render(true)
      puts "Enter the coordinate for your shot:"
      shot = gets.chomp
      until @computer_board.valid_coordinate?(shot)
        puts "Please enter a valid coordinate:"
        shot = gets.chomp
      end
      chosen_cell = @computer_board.cells[shot]
      if chosen_cell.fired_upon?
        while chosen_cell.fired_upon?
        puts "Oops, you've aready fired upon this cell."
        puts "Please select another coordiante:"
        shot = gets.chomp
        chosen_cell = @computer_board.cells[shot]
        end
      end
      chosen_cell.fire_upon
      random_computer_guess = @player_board.cells.values.sample
      until random_computer_guess.fired_upon? == false
        random_computer_guess = @player_board.cells.values.sample
      end
      random_computer_guess.fire_upon

      puts "Results from this turn are as follows:"
      puts "Your shot on #{chosen_cell.coordinate} was a #{chosen_cell.render}."
      puts "My shot on #{random_computer_guess.coordinate} was a #{random_computer_guess.render}."
    end

  end

  def game_over
    if @computer_submarine.sunk? && @computer_cruiser.sunk?
      puts "You won!"
      return true
    end
    if @player_submarine.sunk? && @player_cruiser.sunk?
      puts "I won!"
      return true
    end
    return false
  end

##############################################################
end
