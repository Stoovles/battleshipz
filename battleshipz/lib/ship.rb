require 'pry'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/computer_player'

class Ship

  attr_reader :name,
              :length,
              :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    @health <= 0
  end

  def hit
    @health -= 1
  end

end
