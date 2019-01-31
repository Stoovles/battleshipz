require 'pry'
class Board

  attr_reader :width, :length #:cells, who is reading length and width?

  def initialize(width, length)
    @width = width
    @length = length
    # @cells = {}
  end

  def cells #call something like make_board
    board_hash = {} #not needed
    letter_converter.each do |coordinate|
      board_hash[coordinate] = Cell.new(coordinate) #@cells[coordinate] = Cell.new(coordinate)
    end
    board_hash  #not needed
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

#blahhhhhhhhh blah blah. only works for first coordinate- odn't use a loop
  def valid_coordinate?(coordinate)
    cells.keys.each do |key| #cells or @cells
      if key == coordinate
        return true
      else
        return false
      end
    end
  end
  # def valid_coordinate?(coordinate)
  #   cells.keys.include?(coordinate)
  # end
end
