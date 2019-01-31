require 'pry'
class Board

attr_reader :width, :length

  def initialize(width, length)
    @width = width
    @length = length
  end

  def cells
    board_hash = {}
    letter_converter.each do |coordinate|
      board_hash[coordinate] = Cell.new(coordinate)
    end
    board_hash
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
    letter_array.each do |letter|
      coordinate_array << letter + counter.to_s
      counter += 1
      if counter > @length
        counter = 1
      end
    end
    coordinate_array
  end

  def valid_coordinate?(coordinate)
    cells.keys.each do |key|
      if key == coordinate
        return true
      else
        return false
      end 
    end
  end


end
