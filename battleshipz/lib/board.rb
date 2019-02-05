require 'pry'

class Board

  attr_reader :width, :length, :cells

  def initialize(width, length)
    @width = width
    @length = length
    @cells = {}
    board_hash
  end

  def board_hash
    (65..(64 + @width)).map do |letter|
      (1..@length).map do |number|
        @cells["#{letter.chr}#{number}"] = Cell.new("#{letter.chr}#{number}")
      end
    end.flatten
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
      puts "Invalid number of coordinates."
      return false
    end
    if !valid_placement_coordinate?(ship, coordinates)
      puts "Invalid coordinate."
      return false
    end
    if !valid_placement_consecutive?(ship, coordinates)
      puts "Coordinates are not consecutive. Invalid!"
      return false
    end
    if !valid_placement_overlap?(ship, coordinates)
      puts "Your ship overlaps. Invalid!"
      return false
    end
  return true
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)
      end
      return true
    else
      return false
    end
  end

  def render(optional = false)
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
