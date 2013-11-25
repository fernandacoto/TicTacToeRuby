class Computer_logic
  def initialize
    @move = []
    @Computer_moves = []
    @User_moves = []
  end

  def computer_can_win?(board)
    @move = []
    get_options(board)
    check_rows(board,@Computer_moves)
    if @move.empty?
      check_columns(board,@Computer_moves)
      check_diagonals(board,"X")
    end
    user_can_win?(board) if @move.empty?
    random_move(board) if @move.empty?
    return @move
  end

  def random(board)
    @move = [1,2]
  end

  def get_options(board)
    check_options(board,0,"O",@Computer_moves)
    check_options(board,1,"O",@Computer_moves)
    check_options(board,2,"O",@Computer_moves)
  end

  def user_can_win?(board)
    @move = []
    check_rows(board,@User_moves)
    if @move.empty?
      check_columns(board,@User_moves)
      check_diagonals(board,"O")
    end
    return @move
  end

  def check_diagonals(board, player_symbol)
  end

  def same_symbol(cell_one,cell_two, symbol)
    if cell_one == symbol and cell_two == symbol
      true
    else
      false
    end
    print "in same symbol"
  end

  def check_rows(board,player)
    case 2
    when can_win?(0,0,player)
      row_winner_movement(board,0)
    when can_win?(1,0,player)
      row_winner_movement(board,1)
    when can_win?(2,0,player)
      row_winner_movement(board,2)
    end
  end

  def check_columns(board,player)
    case 2
    when can_win?(0,1,player)
     column_winner_movement(board,0)
    when can_win?(1,1,player)
      column_winner_movement(board,1)
    when can_win?(2,1,player)
      column_winner_movement(board,2)
    end
  end

  def row_winner_movement(board,row)
    counter = 0
    3.times do
      @move = [row, counter] if board[row][counter] == " "
      counter += 1
    end
  end

  def column_winner_movement(board,column)
    counter = 0
    3.times do
      @move = [counter, column] if board[counter][column] == " "
      counter += 1
    end
  end

  def check_options(board, row, player_symbol, player)
    column = 0
    3.times do 
      player<< [row,column] if board[row][column].eql? player_symbol
      column += 1
    end
  end

  def can_win?(element,row_column,player)
    counter = 0
    player.each_index do |index|
      counter += 1 if player[index][row_column].eql? element
    end
    counter
  end
  
  def random_move(board)
    if board[1][1].eql? " "
      cell = [1,1]
    else
      cell = find_empty_cell(board)
    end
  end

  def find_empty_cell(board)
    [2,0]
  end

  def block_user(board)
    check_options(board,0,"X",@User_moves)
    check_options(board,1,"X",@User_moves)
    check_options(board,2,"X",@User_moves)
    user_can_win?(board)
    if @move.empty?
      computer_can_win?(board)
    end
    return @move
  end

  def check_diagonals(board, player_symbol)
    if board[1][1].eql? player_symbol
      compare_boxes(board,0,0,2,2,player_symbol)
      compare_boxes(board,0,2,2,0,player_symbol)
    end
  end
  
  def compare_boxes(board,row_1,column_1,row_2,column_2,player_symbol)
      if board[row_1][column_1].eql? player_symbol and board[row_2][column_2].eql?" "
        @move = [row_2,column_2]
      elsif board[row_1][column_1].eql?" " and board[row_2][column_2].eql? player_symbol
        @move = [row_1,column_1]
      end
  end
end
