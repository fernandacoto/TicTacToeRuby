require "spec_helper"
describe Winner_logic do
  before(:all) do
    @winner = Winner_logic.new()
  end
  describe "tells if there is a winner" do
    it "returns true given a board with Player one winning" do 
      board = [["X","O","X"],["X","O","O"],["X"," "," "]]
      result = @winner.is_there_winner("X",board)
      expect(result).to eq(true)
    end
  end
end
