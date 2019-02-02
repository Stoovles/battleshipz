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

  def valid_placement_overlap?(ship, coordinates)
    coordinates.each do |coordinate|
      if !valid_coordinate?(coordinate)
        return false
      end
      if !@cells[coordinate].empty?
        return false
      end
    end
    return true
  end

  def valid_placement?(ship, coordinates)
    coordinates.sort!
    if !valid_placement_length?(ship, coordinates)
      return false
    end
    # true = continue to vp_coordinate; false = "Invalid coordinates."
    if !valid_placement_coordinate?(ship, coordinates)
      return false
    end
    if !valid_placement_consecutive?(ship, coordinates)
      return false
    end
    if !valid_placement_overlap?(ship, coordinates)
      return false
    end
      return true
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)
      end
    end
  end

  # def render(optional = false)
  #   #output for 4 x 4 board => 1 2 3 4
  #   render_variable = ""
  #   (1..@width).each do |number|
  #     render_variable << "  #{number}"
  #   end
  #   render_variable = "#{render_variable}  \n"
  #   counter = 0
  #   @cells.values.each do |cell_object|
  #     if counter == 0
  #       render_variable << "#{cell_object.coordinate[0]} "
  #     end
  #     render_variable << "#{cell_object.render}  "
  #     counter += 1
  #     if counter == @width
  #       render_variable << "\n"
  #       counter = 0
  #     end
  #   end
  #   render_variable
  # end

  def render(optional = false)
    #output for 4 x 4 board => 1 2 3 4
    render_variable = ""
    (1..@length).each do |number|
      render_variable << "  #{number}"
    end
    render_variable = "#{render_variable}  \n"
    counter = 0
    @cells.values.each do |cell_object|
      if counter == 0
        render_variable << "#{cell_object.coordinate[0]} "
      end
      if optional == true
        render_variable << "#{cell_object.render(true)}  "
        counter += 1
      else
        render_variable << "#{cell_object.render}  "
        counter += 1
      end
      if counter == @length
        render_variable << "\n"
        counter = 0
      end
    end
    render_variable
  end

end
