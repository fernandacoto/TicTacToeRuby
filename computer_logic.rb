class Computer_logic
  Computer_moves = []
  User_moves = []
  def initialize
    @move = []
  end

  def computer_can_win?(board)
    check_rows(board, Computer_moves)
    if @move.empty?
      check_columns(board,Computer_moves)
    end
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
end
