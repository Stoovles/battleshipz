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
    random_cell = computer_player.choose_random_cell(board)

    assert_instance_of Cell, random_cell
  end

  def test_choose_random_cells_placement_cruiser_validity
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    cruiser = Ship.new("Cruiser", 3)
    random_cell = computer_player.choose_random_cell(board)
    cruiser_coordinates = computer_player.choose_random_cells_placement_cruiser(board, random_cell)

    assert board.valid_placement?(cruiser, cruiser_coordinates)
  end

  def test_choose_random_cells_placement_submarine_validity
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    submarine = Ship.new("Submarine", 2)
    random_cell = computer_player.choose_random_cell(board)
    submarine_coordinates = computer_player.choose_random_cells_placement_submarine(board, random_cell)

    assert board.valid_placement?(submarine, submarine_coordinates)
  end

  def test_choose_random_cell_to_fire_upon_chooses_random_not_fired_upon_cell
    computer_player = ComputerPlayer.new
    board = Board.new(4,4)
    random_cell = computer_player.choose_random_cell_to_fire_upon(board)
    assert_instance_of Cell, random_cell
  end

  def test_smart_computer_guesses_correct_possible_cell_when_one_previous_hit
    computer_player = ComputerPlayer.new
    player_board = Board.new(4,4)
    player_submarine = Ship.new("Submarine", 2)
    player_cruiser = Ship.new("Cruiser", 3)

    player_board.place(player_cruiser, ["A1", "A2", "A3"])
    player_board.place(player_submarine, ["D1", "D2"])

    cell_a1 = player_board.cells["A1"]
    cell_a2 = player_board.cells["A2"]
    cell_b1 = player_board.cells["B1"]
    cell_a1.fire_upon
    computer_player.computer_guesses << cell_a1
    smart_guess = computer_player.smart_computer(player_board)
    test = smart_guess == cell_a2 || smart_guess == cell_b1

    assert_instance_of Cell, smart_guess
    assert_equal true , test
  end

  def test_smart_computer_stores_correct_possible_cell_when_two_previous_hits
    computer_player = ComputerPlayer.new
    player_board = Board.new(4,4)
    player_submarine = Ship.new("Submarine", 2)
    player_cruiser = Ship.new("Cruiser", 3)

    player_board.place(player_cruiser, ["A1", "A2", "A3"])
    player_board.place(player_submarine, ["D1", "D2"])

    cell_a1 = player_board.cells["A1"]
    cell_a2 = player_board.cells["A2"]
    cell_a3 = player_board.cells["A3"]
    cell_a1.fire_upon
    cell_a2.fire_upon

    computer_player.computer_guesses << cell_a1
    computer_player.computer_guesses << cell_a2
    smart_guess = computer_player.smart_computer(player_board)
    test = smart_guess == cell_a3

    assert_instance_of Cell, smart_guess
    assert_equal true, test
  end

  def test_smart_computer_remembers_previous_hit_after_sunk_ship
    computer_player = ComputerPlayer.new
    player_board = Board.new(4,4)
    player_submarine = Ship.new("Submarine", 2)
    player_cruiser = Ship.new("Cruiser", 3)

    player_board.place(player_cruiser, ["A1", "A2", "A3"])
    player_board.place(player_submarine, ["A4", "B4"])

    cell_a1 = player_board.cells["A1"]
    cell_a2 = player_board.cells["A2"]
    cell_a3 = player_board.cells["A3"]
    cell_a4 = player_board.cells["A4"]
    cell_b4 = player_board.cells["B4"]
    cell_a4.fire_upon
    cell_a3.fire_upon
    cell_a2.fire_upon
    computer_player.computer_guesses << cell_a4
    computer_player.computer_guesses << cell_a3
    computer_player.computer_guesses << cell_a2
    computer_player.smart_computer(player_board)
    smart_guess = computer_player.smart_computer(player_board)

    assert_equal cell_b4, smart_guess
  end

end
