require 'pry'

class ComputerPlayer

  # def initialize
  #
  # end

  def choose_random_cell(board)
    loop do
      random_cell = board.cells.values.sample
        if random_cell.empty?
          return random_cell
        end
    end
  end

  def choose_random_cells_placement_submarine(board, random_cell)

    possible_next_cells = board.cells.values.find_all do |cell_object|
      random_cell.coordinate[0].ord + 1 == cell_object.coordinate[0].ord &&
      random_cell.coordinate[1] == cell_object.coordinate[1] ||
      random_cell.coordinate[0].ord - 1 == cell_object.coordinate[0].ord &&
      random_cell.coordinate[1] == cell_object.coordinate[1] ||
      random_cell.coordinate[0] == cell_object.coordinate[0] &&
      random_cell.coordinate[1].to_i + 1 == cell_object.coordinate[1].to_i ||
      random_cell.coordinate[0] == cell_object.coordinate[0] &&
      random_cell.coordinate[1].to_i - 1 == cell_object.coordinate[1].to_i
    end
    possible_next_cells = possible_next_cells.find_all do |cell_object|
      cell_object.empty?
    end
    next_cell = possible_next_cells.sample
    coordinates_for_submarine = [random_cell.coordinate, next_cell.coordinate]
    end

    def choose_random_cells_placement_cruiser(board, random_cell)
      cruiser_coordinates = []
      cruiser_coordinates << random_cell.coordinate
      possible_next_cells = board.cells.values.find_all do |cell_object|
        random_cell.coordinate[0].ord + 1 == cell_object.coordinate[0].ord &&
        random_cell.coordinate[1] == cell_object.coordinate[1] ||
        random_cell.coordinate[0].ord - 1 == cell_object.coordinate[0].ord &&
        random_cell.coordinate[1] == cell_object.coordinate[1] ||
        random_cell.coordinate[0] == cell_object.coordinate[0] &&
        random_cell.coordinate[1].to_i + 1 == cell_object.coordinate[1].to_i ||
        random_cell.coordinate[0] == cell_object.coordinate[0] &&
        random_cell.coordinate[1].to_i - 1 == cell_object.coordinate[1].to_i
      end
      possible_next_cells = possible_next_cells.find_all do |cell_object|
        cell_object.empty?
      end
      next_cell = possible_next_cells.sample
      cruiser_coordinates << next_cell.coordinate
      if random_cell.coordinate[0].ord + 1 == next_cell.coordinate[0].ord
        possible_next_cells = board.cells.values.find_all do |cell_object|
          random_cell.coordinate[0].ord - 1 == cell_object.coordinate[0].ord &&
          random_cell.coordinate[1] == cell_object.coordinate[1] ||
          random_cell.coordinate[0].ord - 2 == cell_object.coordinate[0].ord &&
          random_cell.coordinate[1] == cell_object.coordinate[1]
        end
        elsif random_cell.coordinate[0].ord - 1 == next_cell.coordinate[0].ord
          possible_next_cells = board.cells.values.find_all do |cell_object|
            random_cell.coordinate[0].ord + 1 == cell_object.coordinate[0].ord &&
            random_cell.coordinate[1] == cell_object.coordinate[1] ||
            random_cell.coordinate[0].ord + 2 == cell_object.coordinate[0].ord &&
            random_cell.coordinate[1] == cell_object.coordinate[1]
          end
        elsif random_cell.coordinate[1].to_i + 1 = next_cell.coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            random_cell.coordinate[0] == cell_object.coordinate[0] &&
            random_cell.coordinate[1].to_i - 1 == cell_object.coordinate[1].to_i ||
            random_cell.coordinate[0] == cell_object.coordinate[0] &&
            random_cell.coordinate[1].to_i - 2 == cell_object.coordinate[1].to_i
          end
        elsif random_cell.coordinate[1].to_i - 1 = next_cell.coordinate[1].to_i
          possible_next_cells = board.cells.values.find_all do |cell_object|
            random_cell.coordinate[0] == cell_object.coordinate[0] &&
            random_cell.coordinate[1].to_i + 1 == cell_object.coordinate[1].to_i ||
            random_cell.coordinate[0] == cell_object.coordinate[0] &&
            random_cell.coordinate[1].to_i + 2 == cell_object.coordinate[1].to_i
          end
      end
      possible_next_cells = possible_next_cells.find_all do |cell_object|
        cell_object.empty?
      next_cell = possible_next_cells.sample


      end
end
