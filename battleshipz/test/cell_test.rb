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
    refute cell_1.fire_upon
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

  def test_when_cell_fired_upon_ship_health_decrements
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    cell_1.fire_upon
    assert_equal 1, submarine.health
  end

  def test_cell_can_render
    cell_1 = Cell.new("A1")
    refute cell_1.fired_upon?
    assert_equal ".", cell_1.render

    cell_1.fire_upon
    assert_equal "M", cell_1.render

    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    cell_1.fire_upon
    assert_equal "H", cell_1.render

    cell_1.fire_upon
    assert_equal "X", cell_1.render
  end

  def test_cell_can_render_period_when_ship_present
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)
    assert_equal ".", cell_1.render
  end

  def test_cell_can_render_s_with_true_argument
    cell_1 = Cell.new("A1")
    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)

    refute cell_1.fired_upon?
    assert_equal "S", cell_1.render(true)
  end

  def test_cell_can_render_other_options_with_true_argument
    cell_1 = Cell.new("A1")
    cell_1.fire_upon
    assert_equal "M", cell_1.render(true)

    submarine = Ship.new("Submarine", 2)
    cell_1.place_ship(submarine)

    cell_1.fire_upon
    assert_equal "H", cell_1.render(true)

    cell_1.fire_upon
    assert_equal "X", cell_1.render(true)
  end

end
