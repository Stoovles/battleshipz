require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_ship_exists
    submarine = Ship.new("Submarine", 2)

    assert_instance_of Ship, submarine
  end

  def test_it_has_attributes
    submarine = Ship.new("Submarine", 2)

    assert_equal "Submarine", submarine.name
    assert_equal 2, submarine.length
    assert_equal 2, submarine.health
  end

  def test_if_starts_not_sunk?
    submarine = Ship.new("Submarine", 2)

    refute submarine.sunk?
  end

  def test_if_sunk?
    submarine = Ship.new("Submarine", 2)

    assert submarine.sunk?
  end

  def test_it_loses_health_when_hit
    submarine = Ship.new("Submarine", 2)
    submarine.hit

    assert_equal 1, submarine.health
  end

end
