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

  

end
