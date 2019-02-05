require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer_player'

class Game

# attr_reader :rows, :columns, :computer_board, :player_board,
#             :computer_submarine, :computer_cruiser

  def initialize
    @rows = 4
    @columns = 4
  end

   def start
    main_menu
    board_setup
    computer_start
    human_place_cruiser
    human_place_submarine
    turn_start
  end

  def main_menu #check while loop
    continue = 1
    while continue == 1
      puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
      decision = gets.chomp
      if decision == "q"
        abort("Well fine, I didn't want to play with you anyway!")
      elsif decision == "p"
        continue = 0
      else
        puts "Let's try that again..."
      end
    end
  end

  def board_setup
    puts "The game board is a grid. Choose a number for the x axis."
    print "> "
    @rows = gets.chomp.to_i
    puts "Now choose a number for the y axis."
    print "> "
    @columns = gets.chomp.to_i
    @human_board = Board.new(@rows, @columns)
    puts @human_board.render
  end

  def computer_start
    @computer_board = Board.new(@rows, @columns)
    @computer_player = ComputerPlayer.new
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)

    random_cell = @computer_player.choose_random_cell(@computer_board)
    submarine_coordinates = @computer_player.choose_random_cells_placement_submarine(@computer_board, random_cell)
    @computer_board.place(@computer_submarine, submarine_coordinates)

    random_cell = @computer_player.choose_random_cell(@computer_board)
    cruiser_coordinates = @computer_player.choose_random_cells_placement_cruiser(@computer_board, random_cell)
    @computer_board.place(@computer_cruiser, cruiser_coordinates)
    puts "Hello Hooman, my name is Rob. I will be your opponent."
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
  end

  def human_place_cruiser
    puts "The cruiser is three coordinates long and the submarine is two."
    puts "Enter three consecutive coordinates for the cruiser:"
    print "> "
    human_cruiser_coordinates = gets.chomp.split
    @human_cruiser = Ship.new("Cruiser", 3)
    if @human_board.place(@human_cruiser, human_cruiser_coordinates) == false
      human_place_cruiser
    end
    puts @human_board.render(true)
  end

  def human_place_submarine
    puts "Enter two consecutive coordinates for the submarine:"
    print "> "
    human_sub_coordinates = gets.chomp.split
    @human_submarine = Ship.new("Submarine", 2)
    if @human_board.place(@human_submarine, human_sub_coordinates) == false
      human_place_submarine
    end
    puts @human_board.render(true)
  end

  def turn_start
    until game_over
      puts "=================COMPUTER BOARD================="
      puts @computer_board.render
      puts "=================PLAYER BOARD==================="
      puts @human_board.render(true)
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
        puts "Please select another coordinate:"
        shot = gets.chomp
        chosen_cell = @computer_board.cells[shot]
        end
      end
      chosen_cell.fire_upon
      computer_shot = @computer_player.smart_computer(@human_board)

      puts "Results from this turn are as follows:"
      puts "Your shot on #{chosen_cell.coordinate} was a #{chosen_cell.render_word}."
      puts "My shot on #{computer_shot.coordinate} was a #{computer_shot.render_word}."
    end
    start
  end

  def game_over
    if @computer_submarine.sunk? && @computer_cruiser.sunk?
      puts "You won!"
      return true
    end
    if @human_submarine.sunk? && @human_cruiser.sunk?
      puts "I won!"
      return true
    end
    return false
  end

end
