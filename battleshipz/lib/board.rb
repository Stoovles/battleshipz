require 'pry'
class Board

  attr_reader :width, :length, :cells

  def initialize(width, length)
    @width = width
    @length = length
    @cells = {}
  end

  def board_hash
    letter_converter.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end
  end

  def letter_converter
    alphabet = ("A".."Z").to_a
    width_letter_array = (1..@width).map do |num|
      num = alphabet[num - 1]
    end
    letter_array = []
    width_letter_array.cycle(@length) do |letter|
      letter_array << letter
    end
    letter_array.sort!
    counter = 1
    coordinate_array = []
    letter_array.each do |letter| #Amy says "Just say no to each."
      coordinate_array << letter + counter.to_s
      counter += 1
      if counter > @length
        counter = 1
      end
    end
    coordinate_array
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement_length?(ship, coordinates)
    ship.length == coordinates.count
  end

  def valid_placement_coordinate?(ship, coordinates)


  def valid_placement?(ship, coordinates)
    #valid_placement_length(ship, coordinate)
    #ship.length = coordinate_array.count

    #valid_placement_coordinate
    #.any // .none

    #valid_placement_consecutive
    #horizontal_check && vertical_check
  end



end
