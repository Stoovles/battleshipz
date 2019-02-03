require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/computer_player'

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

  def test_valid_placement_length?
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_placement_length?(submarine, ["A1", "A2"])
    refute board.valid_placement_length?(submarine, ["rand"])
    refute board.valid_placement_length?(submarine, ["A1", "A2", "A3"])
    assert board.valid_placement_length?(cruiser, ["A1", "A2", "A3"])
    refute board.valid_placement_length?(cruiser, ["rand", "rand"])
    refute board.valid_placement_length?(cruiser, ["A1", "A2", "A3", "A4"])
  end

  def test_valid_placement_coordinate?
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_placement_coordinate?(submarine, ["A1", "A2"])
    refute board.valid_placement_coordinate?(submarine, ["A1", "E2"])
    assert board.valid_placement_coordinate?(cruiser, ["A1", "A2", "A3"])
    refute board.valid_placement_coordinate?(cruiser, ["A1", "A2", "E3"])
  end

  def test_valid_placement_consecutive?
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_placement_consecutive?(submarine, ["D2", "D3"])
    assert board.valid_placement_consecutive?(submarine, ["D4", "D5"])
    refute board.valid_placement_consecutive?(submarine, ["C1", "D2"])
    refute board.valid_placement_consecutive?(submarine, ["B1", "B4"])
    assert board.valid_placement_consecutive?(cruiser, ["D2", "D3", "D4"])
    assert board.valid_placement_consecutive?(cruiser, ["B1", "C1", "D1"])
    refute board.valid_placement_consecutive?(cruiser, ["D1", "D2", "D4"])
  end

  def test_valid_placement_overlap? #overlap
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    refute board.valid_placement_overlap?(submarine, ["A1", "B1"])
    refute board.valid_placement_overlap?(submarine, ["A2", "B2"])
    refute board.valid_placement_overlap?(submarine, ["A2", "A3"])
    refute board.valid_placement_overlap?(submarine, ["F10", "E9"])
    assert board.valid_placement_overlap?(submarine, ["C2", "C3"])
  end

  def test_valid_placement?
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B2", "B3", "B4"])
    refute board.valid_placement?(submarine, ["E1", "C2"])
    refute board.valid_placement?(cruiser, ["C1", "C2", "D3"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "A1"])
    refute board.valid_placement?(cruiser, ["B1", "C1", "E1"])
    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
  end

  def test_it_can_place_a_ship
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_4 = board.cells["A4"]

    assert_equal cell_1.ship, cell_2.ship
    assert_equal cell_2.ship, cell_3.ship
    refute_equal cell_3.ship, cell_4.ship
  end

  def test_it_can_render_empty_board
    board = Board.new(4,4)
    board.board_hash

    expected = "  1  2  3  4  \n" +
               "A .  .  .  .  \n" +
               "B .  .  .  .  \n" +
               "C .  .  .  .  \n" +
               "D .  .  .  .  \n"

    assert_equal expected, board.render
  end

  def test_it_can_render_cell_with_optional_false
    board = Board.new(4,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["D1", "D2"])
    cell_a1 = board.cells["A1"]
    cell_b4 = board.cells["B4"]
    cell_d1 = board.cells["D1"]
    cell_d2 = board.cells["D2"]

    cell_a1.fire_upon
    cell_b4.fire_upon
    cell_d1.fire_upon
    cell_d2.fire_upon

    expected = "  1  2  3  4  \n" +
               "A H  .  .  .  \n" +
               "B .  .  .  M  \n" +
               "C .  .  .  .  \n" +
               "D X  X  .  .  \n"

    assert_equal expected, board.render
  end

  def test_it_can_render_cell_with_optional_false_5_by_4
    board = Board.new(5,4)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["D1", "D2"])
    cell_a1 = board.cells["A1"]
    cell_b4 = board.cells["B4"]
    cell_d1 = board.cells["D1"]
    cell_d2 = board.cells["D2"]

    cell_a1.fire_upon
    cell_b4.fire_upon
    cell_d1.fire_upon
    cell_d2.fire_upon

    expected = "  1  2  3  4  \n" +
               "A H  .  .  .  \n" +
               "B .  .  .  M  \n" +
               "C .  .  .  .  \n" +
               "D X  X  .  .  \n" +
               "E .  .  .  .  \n"
    assert_equal expected, board.render
  end

  def test_it_can_render_cell_with_optional_false_4_by_5
    board = Board.new(4,5)
    board.board_hash
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["D1", "D2"])
    cell_a1 = board.cells["A1"]
    cell_b4 = board.cells["B4"]
    cell_d1 = board.cells["D1"]
    cell_d2 = board.cells["D2"]

    cell_a1.fire_upon
    cell_b4.fire_upon
    cell_d1.fire_upon
    cell_d2.fire_upon

    expected = "  1  2  3  4  5  \n" +
               "A H  .  .  .  .  \n" +
               "B .  .  .  M  .  \n" +
               "C .  .  .  .  .  \n" +
               "D X  X  .  .  .  \n"
    assert_equal expected, board.render
  end

  def test_it_can_render_with_optional_true
    board = Board.new(4,4)
    board.board_hash

    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["D1", "D2"])
    cell_a1 = board.cells["A1"]
    cell_b4 = board.cells["B4"]
    cell_d1 = board.cells["D1"]
    cell_d2 = board.cells["D2"]

    cell_a1.fire_upon
    cell_b4.fire_upon
    cell_d1.fire_upon
    cell_d2.fire_upon

    expected = "  1  2  3  4  \n" +
               "A H  S  S  .  \n" +
               "B .  .  .  M  \n" +
               "C .  .  .  .  \n" +
               "D X  X  .  .  \n"

    assert_equal expected, board.render(true)
  end

end
