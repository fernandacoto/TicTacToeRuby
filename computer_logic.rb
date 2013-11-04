class Computer_logic
  $solution_founded
  $actual_symbol
  $symbol_founded
  $row
  $column
  $number_occupied_boxes
  $move
  $searching_iterations

  def initialize
    $row = 0
    $column = 0
    $actual_symbol = "O"
    $move = []
  end

  def start_computer_move(board, occupied_boxes)
    $row = 0
    $column = 0
    $number_occupied_boxes = occupied_boxes
    random_move?(board)
    return $move
  end

  def random_move?(board)
    if $number_occupied_boxes < 3 
      found_empty_row(board)
    else
      chose_move(board)
    end
  end

  def chose_move(board)
    found_empty_row(board)
    is_solution?(board)
    return $move
  end

  def is_solution?(board)
    if $solution_founded
      return $move
    else
      verify_possibility_to_win(board)
    end
  end

  def verify_possibility_to_win(board)
    $actual_symbol = "X"
    $solution_founded = false
    $solution_founded = find_winning_options(board)
    mark_or_find?(board)
  end

  def mark_or_find?(board)
    if $solution_founded 
      return $move
    else
      check_rigth_move(board)
    end
  end

  def check_rigth_move(board)
    if !$solution_founded
      $row = 0
      $column = 0
      $actual_symbol = " "
      $symbol_founded = false
      make_first_move(board)
    end
  end

  def find_winning_options(board)
    iterations = repeat_solution_searching
    iterations.times do
      find_row(board)
      check_user_board(board)
    end
    return $solution_founded
  end

  def repeat_solution_searching
    occupied_boxes = $number_occupied_boxes % 2
    if occupied_boxes.even?
      return occupied_boxes
    else
      return (($number_occupied_boxes - 1) / 2) + 1
    end
  end

  def check_user_board(board)
    check_rows(board)
    check_columns(board)
    check_diagonals(board)
  end

  def check_diagonals(board)
    if !$solution_founded and board[1][1].eql?$actual_symbol
      $row = 1
      $column = 1
      compare_boxes(board,$row - 1,$column - 1,$row + 1,$column + 1)
      compare_boxes(board,$row - 1,$column + 1,$row + 1,$column - 1)
    end
  end

  def found_empty_row(board)
    $symbol_founded = false
    if $number_occupied_boxes < 2
      make_first_move(board)
    else
      make_next_move(board)
    end
  end

  def make_first_move(board)
    if board[1][1].eql? " "
      2.times do $move.push(1) end
    else
      find_movement(board)
    end
  end

  def find_movement(board)
    while !$symbol_founded and  $row < 3
      find_empty_column(board)
      if !$symbol_founded 
        $row += 1
        $column = 0
      end
    end
  end

  def find_empty_column(board)
     $actual_symbol = " "
     while !$symbol_founded and $column < 3
       if board[$row][$column].eql?$actual_symbol
         $move[0] = $row
         $move[1] = $column
         $symbol_founded = true
       else
         $column += 1
       end
     end
  end

  def make_next_move(board)
    $actual_symbol = "O"
    $searching_iterations = $number_occupied_boxes / 2
    $searching_iterations.times do
      find_row(board)
      possibility_to_win(board)
    end
  end
  
  def find_row(board)
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

  def possibility_to_win(board)
    $solution_founded = false
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
    else
      if $row.eql?1
        compare_boxes(board,$row + 1, $column, $row - 1, $column)
      else
        if $row.eql?2
          compare_boxes(board,$row - 1, $column, $row - 2, $column)
        end
      end
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
    if !$solution_founded and row_1 < 3 and row_2 < 3
      if board[row_1][column_1].eql?$actual_symbol and board[row_2][column_2].eql?" "
        $solution_founded = true
        $move[0]=row_2
        $move[1]=column_2
      else 
        if board[row_1][column_1].eql?" " and board[row_2][column_2].eql?$actual_symbol
        $solution_founded = true
        $move[0]=row_1
        $move[1]=column_1
        else 
          $solution_founded = false
        end
      end
    end
    return $solution_founded
  end

end
