class Winner_logic
  def initialize
    @solution_founded = false
  end

  def is_there_winner(symbol,board)
    check_rows(symbol,board)
    check_columns(symbol,board)
    check_diagonals(symbol,board)
    @solution_founded
  end

  def check_rows(symbol,board)
    compare_cells(0,0,0,1,0,2,board,symbol)
    compare_cells(1,0,1,1,1,2,board,symbol)
    compare_cells(2,0,2,1,2,2,board,symbol)
  end

  def check_columns(symbol,board)
    compare_cells(0,0,1,0,2,0,board,symbol)
    compare_cells(0,1,1,1,2,1,board,symbol)
    compare_cells(0,2,1,2,2,2,board,symbol)
  end

  def check_diagonals(symbol,board)
    compare_cells(0,0,1,1,2,2,board,symbol)
    compare_cells(0,2,1,1,2,0,board,symbol)
  end

  def compare_cells(row_1,column_1,row_2,column_2,row_3,column_3,board,symbol)
    @solution_founded = true if board[row_1][column_1].eql? symbol and board[row_2][column_2].eql? symbol and board[row_3][column_3].eql? symbol
  end
end
