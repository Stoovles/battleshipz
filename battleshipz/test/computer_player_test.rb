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

  def test_choose_random_cells_placement_validity
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    board.board_hash
    random_cell = computer_player.choose_random_cell(board)
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal [], computer_player.choose_random_cells_placement(board, random_cell, cruiser)
  end


end
