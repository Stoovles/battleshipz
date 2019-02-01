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

  def check_horizontal_or_vertical(coordinates)
    check_horizontal = []
    coordinates.each do |coordinate|
      check_horizontal << coordinate[0]
    end
    if check_horizontal.uniq.count == 1 #[A] == 1 : confirms all letters are same
      check_cons_numbers = []
      coordinates.each do |coordinate|
        check_cons_numbers << coordinate[1].to_i
      end
        if check_cons_numbers.each_cons(2).all? do |number_1, number_2|
          number_2 == number_1 + 1
        end
          #confirms numbers are consecutive, e.g. [1, 2, 3]
          return true #valid_placement_consecutive? == true
        else
          return false #valid_placement_consecutive == false
        end
    else
      check_vertical(coordinates)
    end
  end

  def check_vertical(coordinates)
    check_vertical = []
    coordinates.each do |coordinate|
      check_vertical << coordinate[0]
    end
    check_cons_letters = []
    check_cons_letters = check_vertical.map do |letter|
      letter.ord
    end
    if check_cons_letters.each_cons(2).all? do |letter_1, letter_2|
      letter_2 == letter_1 + 1
    end
    #[A, B, C] == 3 : confirms all different letters
      check_duplicate_numbers = []
      coordinates.each do |coordinate| #[1].count == 1 : checks if one unique number
        check_duplicate_numbers << coordinate[1]
      end
      if check_duplicate_numbers.uniq.count == 1
        return true #valid_placement_consecutive == true
      else
        return false
      end
    else
      return false
    end
  end

  def valid_placement_consecutive?(ship, coordinates)
    check_horizontal_or_vertical(coordinates)
  end

  def valid_placement_ship?(ship, coordinates)
    counter = 0
    cells_with_ships = @cells.values.find_all do |cell_object|
      cell_object.ship != nil
    end
    cells_with_ships.each do |cell_object|
      if cell_object.coordinate == coordinates[counter]
        return false
      end
      counter += 1
    end
    return true
  end

  #for some reason the order matters
  #if I place valid_placement_ship? last,
  #it fails a test within test_valid_placement?
  def valid_placement?(ship, coordinates)
    coordinates.sort!
    valid_placement_ship?(ship, coordinates)
    valid_placement_length?(ship, coordinates)
    valid_placement_coordinate?(ship, coordinates)
    valid_placement_consecutive?(ship, coordinates)


  end

  # def place(ship, coordinates)
  #   @cells.values.each do |cell_object|
  #     coordinates.each do |coord|
  #       if coord == cell_object.coordinate
  #         cell_object.place_ship(ship)
  #       end
  #     end
  #   end
  # end
  def place(ship, coordinates)
    counter = 0
    @cells.values.each do |cell_object|
      if cell_object.coordinate == coordinates[counter]
        cell_object.place_ship(ship)
        counter += 1
      end
    end
  end

  def render(optional = false)
  #If you run board_test.rb as is you will see the rendered board without the letter
  #and number row/column. The following two commented out pieces of code create said
  #column/row. Factoring them into the uncommented piece of code does not seem too difficult
  #but I am exhausted ... zzzz

  #Directions: there is a binding.pry on line 165 of board_test
  #ruby test/board_test.rb
  #play -l 166

    #output for 4 x 4 board => 1 2 3 4
    # (1..@width).each do |number|
    #   print number, "  "
    # end
    #
    #output for 4 x 4 board => A \n B \n C \n D
    # (65..(65+@length)).each do |number|
    #   puts number.chr
    # end
    counter = 0
    @cells.values.each do |cell_object|
      print cell_object.render, " "
      counter += 1
      if counter == @width
        p "\n"
        counter = 0
      end
    end

  end


end
