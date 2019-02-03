require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer_player'

class ComputerPlayerTest < Minitest::Test

  def test_it_exists
    computer_player = ComputerPlayer.new

    assert_instance_of ComputerPlayer, computer_player
  end

  def test_it_can_choose_random_cell
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    board.board_hash
    random_cell = computer_player.choose_random_cell(board)

    assert_instance_of Cell, random_cell
  end

  def test_choose_random_cells_placement_cruiser_validity
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    board.board_hash
    cruiser = Ship.new("Cruiser", 3)
    random_cell = computer_player.choose_random_cell(board)
    cruiser_coordinates = computer_player.choose_random_cells_placement_cruiser(board, random_cell)

    assert board.valid_placement?(cruiser, cruiser_coordinates)
  end

  def test_choose_random_cells_placement_submarine_validity
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    random_cell = computer_player.choose_random_cell(board)
    submarine_coordinates = computer_player.choose_random_cells_placement_submarine(board, random_cell)
    
    assert board.valid_placement?(submarine, submarine_coordinates)
  end

end
