require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new(4, 4)

    assert_instance_of Board, board
  end

  def test_it_can_convert_with_varying_width_length_to_coordinate_array
    board = Board.new(4, 4)
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal expected, board.letter_converter

    board = Board.new(5, 4)
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4", "E1", "E2", "E3", "E4"]
    assert_equal expected, board.letter_converter

    board = Board.new(4, 5)
    expected = ["A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "B4", "B5", "C1", "C2", "C3", "C4", "C5", "D1", "D2", "D3", "D4", "D5"]
    assert_equal expected, board.letter_converter
  end

  def test_if_board_can_populate_board_with_cells
    board = Board.new(4, 4)
    board.letter_converter
    board.board_hash

    assert_equal 16, board.cells.keys.count
    assert_instance_of Cell, board.cells.values[0]
  end

  def test_valid_coordinate?
    board = Board.new(4,4)
    board.board_hash

    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("A2")
    refute board.valid_coordinate?("Z10")
  end

  def test_valid_placement_if_ship_length_and_coordinate_array_count_match
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)


    assert board.valid_placement_length?(submarine, ["A1", "A2"])
    refute board.valid_placement_length?(submarine, ["A1", "A2", "A3"])
  end

  def test_valid_placement_if_coordinate_on_board
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)

    assert board.valid_placement_coordinate?(submarine, ["C1", "D1"])
    refute board.valid_placement_coordinate?(submarine, ["Z1", "A1"])
    refute board.valid_placement_coordinate?(submarine, ["A8", "B1"])
  end

  def test_valid_placement_if_consecutive
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_placement_consecutive?(cruiser, ["A1", "A2", "A3"])
    assert board.valid_placement_consecutive?(submarine, ["C1", "D1"])
    refute board.valid_placement_consecutive?(submarine, ["C1", "D4"])
    refute board.valid_placement_consecutive?(cruiser, ["A1", "C1", "D1"])
  end

  def test_valid_placement_if_diagonal
    skip
  end


  def test_valid_placement?
    skip
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B2", "B3", "B4"])
    refute board.valid_placement?(submarine, ["E1", "C2"])
  end
end
