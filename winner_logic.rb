class Logica_Ganador
  $solution_founded
  $actual_symbol
  $symbol_founded
  $row
  $column
  $number_of_moves
  $first_player

  def initialize
    $row = 0
    $column = 0
    $first_player = 1
  end

  def start_find_winner(board,player,movements)
    $number_of_moves = movements
    $row = 0
    $column = 0 
    pick_player(player)
    searching_iterations(board)
    check_solution
  end

  def pick_player(player)
    if player.eql?$first_player
      $actual_symbol = "X"
    else
      $actual_symbol = "O"
    end
  end

  def searching_iterations(board)
    $solution_founded = false
    $symbol_founded = false
    find_column(board)
    check_board(board)
    if !check_solution
      $symbol_founded = false
      $row = 1
      $column = 0
      find_column(board)
      if $symbol_founded
        check_board(board)
      end
    end
    if !check_solution
        $symbol_founded = false
        $row = 2
        $column = 0
        find_column(board)
        if $symbol_founded
        check_board(board)
        end
    end 
  end

  def encontrar_fila(board)
    $symbol_founded = false
    while !$symbol_founded and $row < 3
      find_column(board)
      if !$symbol_founded
        $row += 1
        $column = 0
      end
    end
  end

  def find_column(board)
    while !$symbol_founded and $column < 3
      if board[$row][$column].eql?$actual_symbol
        $symbol_founded = true
      else
        $column += 1
      end
    end
  end

  def check_board(board)
    check_rows(board)
    check_columns(board)
    if !$solution_founded and board[1][1].eql?$actual_symbol
      $row = 1
      $column = 1
      compare_boxes(board,$row - 1,$column - 1,$row + 1,$column + 1)
      compare_boxes(board,$row - 1,$column + 1,$row + 1,$column - 1)
    end
  end

  def check_rows(board)
    if $row.eql?0
      compare_boxes(board,$row + 1, $column, $row + 2, $column)
    elsif $row.eql?1
        compare_boxes(board,$row + 1, $column, $row - 1, $column)
      elsif $row.eql?2
          compare_boxes(board,$row - 1, $column, $row - 2, $column)
    end
  end

  def check_columns(board)
    if $column.eql?0
      compare_boxes(board,$row,$column + 1, $row,$column + 2)
    else
      if $column.eql?1
        compare_boxes(board,$row,$column + 1, $row,$column - 1)
      else
        if $column.eql?2
          compare_boxes(board,$row,$column - 1, $row,$column - 2)
        end
      end
    end
  end

  def compare_boxes(board,row_1,column_1,row_2,column_2)
    if board[row_1][column_1].eql?$actual_symbol and board[row_2][column_2].eql?$actual_symbol
      $solution_founded = true
    end
   return $solution_founded
  end
 
  def check_solution
    return $solution_founded
  end
end
