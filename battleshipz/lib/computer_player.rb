require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class ComputerPlayer

  attr_reader :computer_guesses

  def initialize
    @computer_guesses = []
  end

  def choose_random_cell(board)
    loop do
      random_cell = board.cells.values.sample
        if random_cell.empty?
          return random_cell
        end
    end
  end

  def smart_computer(board)
    if @computer_guesses.length == 0
      random_cell = choose_random_cell_to_fire_upon(board)
      random_cell.fire_upon
      if random_cell.render == "H"
        @computer_guesses << random_cell
      end
      return random_cell
    elsif @computer_guesses.length == 1
        possible_next_cells = board.cells.values.find_all do |cell_object|
          possible_adjacent_cells(@computer_guesses[0], cell_object)
        end
        possible_next_cells = possible_next_cells.find_all do |cell_object|
          !cell_object.fired_upon?
        end
        next_cell = possible_next_cells.sample
        next_cell.fire_upon
        if next_cell.render == "H"
          @computer_guesses << next_cell
        end
        if next_cell.render == "X"
          @computer_guesses = []
          existing_hits = board.cells.values.find do |cell_object|
            cell_object.render == "H"
          end
          if existing_hits != nil
            @computer_guesses << existing_hits
          end
        end
        return next_cell
    elsif @computer_guesses.length == 2
      if @computer_guesses[0].coordinate[0].ord + 1 == @computer_guesses[1].coordinate[0].ord
        possible_next_cells = board.cells.values.find_all do |cell_object|
          possible_cells_above_random_cell_by_1_and_below_by_2(@computer_guesses[0], cell_object)
        end
        # binding.pry
      elsif @computer_guesses[0].coordinate[0].ord - 1 == @computer_guesses[1].coordinate[0].ord
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_above_random_cell_by_2_and_below_by_1(@computer_guesses[0], cell_object)
          end
          # binding.pry
        elsif @computer_guesses[0].coordinate[1].to_i + 1 == @computer_guesses[1].coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_left_random_cell_by_1_and_right_by_2(@computer_guesses[0], cell_object)
          end
          # binding.pry
        elsif @computer_guesses[0].coordinate[1].to_i - 1 == @computer_guesses[1].coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_left_random_cell_by_2_and_right_by_1(@computer_guesses[0], cell_object)
          end
          # binding.pry
      end
      possible_next_cells = possible_next_cells.find_all do |cell_object|
        !cell_object.fired_upon?
      end
      next_cell = possible_next_cells.sample
      next_cell.fire_upon
      if next_cell.render == "H"
        @computer_guesses << next_cell
      end
      if next_cell.render == "X"
        @computer_guesses = []
        existing_hits = board.cells.values.find do |cell_object|
          cell_object.render == "H"
        end
        if existing_hits != nil
          @computer_guesses << existing_hits
        end
      end
      return next_cell
    else
      if @computer_guesses[-2].coordinate[0].ord + 1 == @computer_guesses[-1].coordinate[0].ord
        possible_next_cells = board.cells.values.find_all do |cell_object|
          possible_cells_above_random_cell_by_1_and_below_by_2(@computer_guesses[-2], cell_object)
        end
        # binding.pry
      elsif @computer_guesses[-2].coordinate[0].ord - 1 == @computer_guesses[-1].coordinate[0].ord
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_above_random_cell_by_2_and_below_by_1(@computer_guesses[-2], cell_object)
          end
          # binding.pry
        elsif @computer_guesses[-2].coordinate[1].to_i + 1 == @computer_guesses[-1].coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_left_random_cell_by_1_and_right_by_2(@computer_guesses[-2], cell_object)
          end
          # binding.pry
        elsif @computer_guesses[-2].coordinate[1].to_i - 1 == @computer_guesses[-1].coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_left_random_cell_by_2_and_right_by_1(@computer_guesses[-2], cell_object)
          end
          # binding.pry
      end
      possible_next_cells = possible_next_cells.find_all do |cell_object|
        !cell_object.fired_upon?
      end
      next_cell = possible_next_cells.sample
      next_cell.fire_upon
      if next_cell.render == "H"
        @computer_guesses << next_cell
      end
      if next_cell.render == "X"
        @computer_guesses = []
        existing_hits = board.cells.values.find do |cell_object|
          cell_object.render == "H"
        end
        if existing_hits != nil
          @computer_guesses << existing_hits
        end
      end
      return next_cell
    end
  end

  def choose_random_cell_to_fire_upon(board)
    loop do
      random_cell = board.cells.values.sample
        if !random_cell.fired_upon?
          return random_cell
        end
    end
  end

  def possible_adjacent_cells(random_cell, cell_object)
    random_cell.coordinate[0].ord + 1 == cell_object.coordinate[0].ord &&
    random_cell.coordinate[1] == cell_object.coordinate[1] ||
    random_cell.coordinate[0].ord - 1 == cell_object.coordinate[0].ord &&
    random_cell.coordinate[1] == cell_object.coordinate[1] ||
    random_cell.coordinate[0] == cell_object.coordinate[0] &&
    random_cell.coordinate[1].to_i + 1 == cell_object.coordinate[1].to_i ||
    random_cell.coordinate[0] == cell_object.coordinate[0] &&
    random_cell.coordinate[1].to_i - 1 == cell_object.coordinate[1].to_i
  end

  def possible_cells_above_random_cell_by_1_and_below_by_2(random_cell, cell_object)
    random_cell.coordinate[0].ord - 1 == cell_object.coordinate[0].ord &&
    random_cell.coordinate[1] == cell_object.coordinate[1] ||
    random_cell.coordinate[0].ord + 2 == cell_object.coordinate[0].ord &&
    random_cell.coordinate[1] == cell_object.coordinate[1]
  end

  def possible_cells_above_random_cell_by_2_and_below_by_1(random_cell, cell_object)
    random_cell.coordinate[0].ord + 1 == cell_object.coordinate[0].ord &&
    random_cell.coordinate[1] == cell_object.coordinate[1] ||
    random_cell.coordinate[0].ord - 2 == cell_object.coordinate[0].ord &&
    random_cell.coordinate[1] == cell_object.coordinate[1]
  end

  def possible_cells_left_random_cell_by_1_and_right_by_2(random_cell, cell_object)
    random_cell.coordinate[0] == cell_object.coordinate[0] &&
    random_cell.coordinate[1].to_i - 1 == cell_object.coordinate[1].to_i ||
    random_cell.coordinate[0] == cell_object.coordinate[0] &&
    random_cell.coordinate[1].to_i + 2 == cell_object.coordinate[1].to_i
  end

  def possible_cells_left_random_cell_by_2_and_right_by_1(random_cell, cell_object)
    random_cell.coordinate[0] == cell_object.coordinate[0] &&
    random_cell.coordinate[1].to_i + 1 == cell_object.coordinate[1].to_i ||
    random_cell.coordinate[0] == cell_object.coordinate[0] &&
    random_cell.coordinate[1].to_i - 2 == cell_object.coordinate[1].to_i
  end

  def choose_random_cells_placement_submarine(board, random_cell)
    submarine_coordinates = []
    submarine_coordinates << random_cell.coordinate
    possible_next_cells = board.cells.values.find_all do |cell_object|
      possible_adjacent_cells(random_cell, cell_object)
    end
    possible_next_cells = possible_next_cells.find_all do |cell_object|
      cell_object.empty?
    end
    next_cell = possible_next_cells.sample
    submarine_coordinates << next_cell.coordinate
    # binding.pry
    return submarine_coordinates
  end

  def choose_random_cells_placement_cruiser(board, random_cell)
    cruiser_coordinates = []
    cruiser_coordinates << random_cell.coordinate
    possible_next_cells = board.cells.values.find_all do |cell_object|
      possible_adjacent_cells(random_cell,cell_object)
    end
    possible_next_cells = possible_next_cells.find_all do |cell_object|
      cell_object.empty?
    end

    while cruiser_coordinates.length < 3
      next_cell = possible_next_cells.sample
      cruiser_coordinates << next_cell.coordinate
      if random_cell.coordinate[0].ord + 1 == next_cell.coordinate[0].ord
        possible_next_cells = board.cells.values.find_all do |cell_object|
          possible_cells_above_random_cell_by_1_and_below_by_2(random_cell, cell_object)
        end
        elsif random_cell.coordinate[0].ord - 1 == next_cell.coordinate[0].ord
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_above_random_cell_by_2_and_below_by_1(random_cell, cell_object)
          end
        elsif random_cell.coordinate[1].to_i + 1 == next_cell.coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_left_random_cell_by_1_and_right_by_2(random_cell, cell_object)
          end
        elsif random_cell.coordinate[1].to_i - 1 == next_cell.coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            possible_cells_left_random_cell_by_2_and_right_by_1(random_cell, cell_object)
          end
      end
      possible_next_cells = possible_next_cells.find_all do |cell_object|
        cell_object.empty?
      end
      if possible_next_cells.length == 0
        cruiser_coordinates.pop
      end
      next_cell = possible_next_cells.sample
      if next_cell != nil #I think this if nil statement fixed the error
        cruiser_coordinates << next_cell.coordinate #error happens here every once in awhile - reference screenshot
      end
    end
    return cruiser_coordinates
  end


end
