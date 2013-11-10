require_relative "./board.rb"
require_relative "./console_output.rb"
class Players
  Player_one = 1
  Player_two = 2
  Total_movements = 9

  def initialize
    @board = Board.new()
    @display = Console_output.new()
    @winner = false
  end

  def user_user_game
    movements = 0
    player = Player_one
    while movements < Total_movements and @winner.eql? false
      player = select_player(movements,player)
      play(player)
      movements = movements + 1
    end
    @display.end_of_game(@winner,movements,player)
  end
  
  def select_player(movements,player)
    if movements.eql? 0 or player.eql? Player_two
      Player_one 
    else
      Player_two
    end
  end

  def play(player)
    @display.print_message("Player #{player} digit the number of the box in which you wanna move\n")
    row_column = check_availability(which_cell?)
    @winner = @board.make_movement(cell,player)
  end

  def which_cell?
    cell = []
    @display.print_message("Row:")
    input = continue_asking_entry()
    cell[0] = input
    @display.print_message("Column:") 
    input =continue_asking_entry()
    cell[1] = input
    return cell
  end

  def continue_asking_entry()
    input = gets.to_i
    while invalid_move?(input)
       input = gets.to_i
    end
    input
  end

  def invalid_move?(input)
    !(0..2).include?(input)
  end

  def check_availability(row_column)
    unless !@board.empty_box(row_column[0],row_column[1])
      which_cell? 
    else
      row_column
    end
  end

  def user_computer_game
  end
end
