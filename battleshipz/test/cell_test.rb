require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test

  def test_cell_exists
    cell_1 = Cell.new("A1")

    assert_instance_of Cell, cell_1
  end

  def test_cell_attributes
    cell_1 = Cell.new("A1")

    assert_equal "A1", cell_1.coordinate
    assert_nil cell_1.ship
  end

  def test_cell_starts_empty?
    cell_1 = Cell.new("A1")

    assert cell_1.empty?
  end

  def test_cell_can_place_ship
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)

    refute cell_1.empty?
    assert_equal submarine, cell_1.ship
  end

  def test_cell_has_been_fired_upon?
    cell_1 = Cell.new("A1")
    refute cell_1.fired_upon?
    cell_1.fire_upon
    assert cell_1.fired_upon?
  end

  ##render test to be added
  ##fire_upon .hit method test

end
