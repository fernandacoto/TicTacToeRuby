require "spec_helper"
describe Computer_logic do
  before(:all) do
    @computer_logic = Computer_logic.new()
  end
  describe "get the boxes in wich a determine user has made a move" do
    it "checks the board and return in an array the movements of player one 'X'" do 
      board =[["X"," ","O"],["X","O"," "],[" "," "," "]]
      result = @computer_logic.get_options(board)
      expect(result).to eq([[0,2],[1,1]])
    end
  end

  describe "get an empty box" do
    it "returns an empty box when the computer need a random move" do
      board =[["X"," ","O"],["X","O"," "],[" "," "," "]]
      box = @computer_logic.random_move(board)
      expect(box.length).to eq(2)
    end
  end

  describe "get a box when someone can win by a digonal" do
    it "returns the box in wich the computer can win or can block to the other player" do
      board = [["O"," "," "],["X","O","X"],[" "," "," "]]
      box = @computer_logic.check_diagonals(board,"O")
      expect(box).to eq([2,2])
    end
  end
end
