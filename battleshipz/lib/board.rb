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
    coordinates.none? do |coordinate|
      !valid_coordinate?(coordinate)
    end
  end

  def check_horizontal(coordinates)
    check_horizontal = []
    coordinates.each do |coordinate|
      check_horizontal << coordinate[0]
    end
    if check_horizontal.uniq.count == 1
      check_cons_numbers = []
      coordinates.each do |coordinate|
        check_cons_numbers << coordinate[1]
      end
        if check_cons_numbers.each_cons(2).all? do |number_1, number_2|
          number_2 == number_1 + 1
        end
        end
    else
      vertical_check(coordinates)
    end
  end

  def check_vertical(coordiantes)
    check_vertical = []
    coordinates.each do |coordinate|
      check_vertical << coordinate[0]
    end
    if check_vertical.uniq.count == coordinates.count
    

  def valid_placement_consecutive?(ship, coordinates)
    if check_horizontal(coordinates)

  end

  def valid_placement?(ship, coordinates)
    # coordinates.sort!
    #valid_placement_length(ship, coordinate)
    #ship.length = coordinate_array.count

    #valid_placement_coordinate
    #.any // .none

    #valid_placement_consecutive
    #horizontal_check && vertical_check
  end



end
