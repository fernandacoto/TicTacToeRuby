require_relative "./winner_logic.rb"
require_relative "./computer_logic.rb"
class Console_Output
  $is_there_winner
  $row
  $column
  $winner_logic_instance
  $number_occupied_boxes
  $computer_logic_instance
  $max_movements
  $first_player
  $second_player

  def initialize
    @board = [[" "," "," "],[" "," "," "],[" "," "," "]]
    $first_player = 1
    $second_player = 2
    @player = $first_player
    $max_movements = 9
    $winner_logic_instance = Logica_Ganador.new()
    @checking_player = 0
  end
  
  def make_menu
    initialize
    show_options
    option = gets.to_i
    while option != 4 
      process_option(option)
    end
    exit
  end

  def show_options
    print "Tic Tac Toe \n1. Instrucciones \n2. Usuario-Usuario \n3. Usuario-Computadora \n4. Salir \n"
    print "opcion ="
  end
 
  def process_option(option)
    if option.eql?1
      show_instructions
    else
      if option.eql?2
        start_user_game
      else
        if option.eql?3
          start_computer_game
        end
      end
    end
  end

  def show_instructions
    print "Para jugar debe de digitar el numero de la fila y columna en la cual desea jugar\n0 0 | 0 1 | 0 2 \n--------------- \n1 0 | 1 1 | 1 2 \n--------------- \n2 0 | 2 1 | 2 2 \nPor ejemplo para seleccionar la casilla central, cuando se me pide la fila digito 1 y cuando es la columna digito 1 \nPresione cualquier tecla para continuar \n"
    gets 
    make_menu
  end
  
  def start_user_game
    $number_occupied_boxes = 0
    $is_there_winner = false
    paint_board
    keep_playing? 
    make_menu
  end

  def keep_playing?
    while $number_occupied_boxes < $max_movements and !$is_there_winner
      print "Jugador #{@player} digite el numero de la casilla a marcar\n"
      make_move
      $number_occupied_boxes +=1
    end
  end

  def make_move
    validate_data
    pick_player
    @checking_player  = which_player?
    $is_there_winner = $winner_logic_instance.start_find_winner(@board,@checking_player,$number_occupied_boxes)    
    check_winner
  end

  def validate_data
    validate_input("fila ")
    validate_input("columna ")
    check_availability
  end

  def pick_player
    if @player.eql?$first_player
      @board[$row][$column] = "X"
      @player = $second_player
    else
      @board[$row][$column] = "O"
      @player = $first_player
    end
    paint_board
  end

  def which_player?
    if @player.eql?$first_player
      return $second_player
    else
      return $first_player
    end
  end

  def paint_board
    print " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}\n"
    print "------------\n"
    print " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}\n"
    print "------------\n"
    print " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}\n"
  end

  def validate_input(argument)
    print argument
    is_row?(argument)
  end

  def is_row?(argument)
    if argument.eql?"fila "
      $row = gets.to_i
      ask_data_again?($row,"fila ")
    else
      $column = gets.to_i
      ask_data_again?($column, "columna ")
    end
  end

  def ask_data_again?(location,argument)
    while location > 2
      validate_input(argument)
    end
  end

  def check_availability
    while @board[$row][$column] != " "
      print "Casilla Ocupada seleccione otra\n"
      validate_input("fila ")
      validate_input("columna ")
    end
  end
  
  def check_winner
    if $is_there_winner
      print "FIN DEL JUEGO HAY UN GANADOR \n"
      print "Felicidades jugador #{@checking_player }\n"
    end
  end

  def start_computer_game
    $number_occupied_boxes = 0
    $is_there_winner = false
    paint_board
    chose_player
    @checking_player  = $first_player
    $is_there_winner = $winner_logic_instance.start_find_winner(@board,@checking_player ,$number_occupied_boxes)
    check_winner
    make_menu
  end

  def chose_player
    while $number_occupied_boxes < $max_movements and !$is_there_winner
      if @player.eql?$first_player
        make_user_movement 
      else
        make_computer_movement
      end
      $number_occupied_boxes +=1
    end
  end

  def make_user_movement
    print "Jugador #{@player} digite el numero de la casilla a marcar\n"
    validate_data
    @board[$row][$column] = "X"
    @player = $second_player
    paint_board
  end

  def make_computer_movement
    if !$is_there_winner
      continue_playing
    end
  end

  def continue_playing
    print "Movida de la computadora \n"
    $computer_logic_instance = Computer_logic.new()
    result = Array.new()
    result = $computer_logic_instance.start_computer_move(@board,$number_occupied_boxes)
    @board[result[0]][result[1]] = "O"
    $is_there_winner = $winner_logic_instance.start_find_winner(@board,@player,$number_occupied_boxes)
    @checking_player = 2
    check_winner
    @player = $first_player
    paint_board
  end

end
play = Console_Output.new()
play.make_menu
