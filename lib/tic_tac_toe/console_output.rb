class Console_output

  def show_options
    print "Tic Tac Toe \n1. Instructions \n2. User-User \n3. User-Computer \n4. Exit \n"
    print "option ="
  end

  def show_instructions
    print "To play you need to digit the number of the row and column in the place you wanna move\n0 0 | 0 1 | 0 2 \n--------------- \n1 0 | 1 1 | 1 2 \n--------------- \n2 0 | 2 1 | 2 2 \nFor example to select the central box, when is asked the row I digit 1 and when the column is asked I digit 1 \nPress any key to continue \n"
    gets
  end

  def paint_board(board)
    print " #{board[0][0]} | #{board[0][1]} | #{board[0][2]}\n"
    print "------------\n"
    print " #{board[1][0]} | #{board[1][1]} | #{board[1][2]}\n"
    print "------------\n"
    print " #{board[2][0]} | #{board[2][1]} | #{board[2][2]}\n"
  end

  def end_of_game(winner,movements,player)
    if movements.eql? 9 and winner.eql? false
      print "End of game there is no winner\n"
    else
      print "End of game, congratulations player #{player} you win \n"
    end
  end

  def print_message(argument)
    print argument
  end

end

