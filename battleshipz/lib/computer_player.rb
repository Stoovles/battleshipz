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


end
