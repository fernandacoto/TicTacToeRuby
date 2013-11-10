require_relative "./console_output.rb"
require_relative "./winner_logic.rb"
class Board
  def initialize
    @board = [[" "," "," "],[" "," "," "],[" "," "," "]]
    @display = Console_output.new()
    @check_for_winner = Winner_logic.new()
  end
  
  def which_player(player)
    case player
    when 1
      symbol = "X"
    when 2
      symbol = "O"
    end
  end
  
  def empty_box(row,column)
    true if @board[row][column] != " "    
  end

  def make_movement(cell,player)
    @board[cell[0]][cell[1]] = which_player(player)
    @display.paint_board(@board)
    @check_for_winner.is_there_winner(which_player(player),@board)
  end
  
end
