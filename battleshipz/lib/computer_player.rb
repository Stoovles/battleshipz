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

  def choose_random_cells_placement(board, random_cell, ship)
    random_cell_ord = random_cell.coordinate[0].ord + random_cell.coordinate[1].to_i

    ship.length - 1.times do
      possible_next_cell = board.cells.values.find_all do |cell_object|
        cell_object.coordinate[0].ord + cell_object.coordinate[1].to_i == random_cell_ord + 1 ||
        cell_object.coordinate[0].ord + cell_object.coordinate[1].to_i == random_cell_ord - 1
      end
      possible_next_cell.each do |cell_object|
        if board.valid_placement(ship, [cell_object.coordinate, random_cell.coordinate])
          ship_coordinates = [cell.object.coordinate, random_cell.coordinate]
        end
      end
    end

  end


end
