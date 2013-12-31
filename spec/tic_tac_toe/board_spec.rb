require "spec_helper"
describe Board do
  before(:all) do
    @board = Board.new()
  end
  describe "tells which symbols correspond to a specific player" do
    it "returns an 'X' when called with argument 1" do 
      result = @board.which_player(1)
      expect(result).to eq('X')
    end
  end

  describe "tells if a box is accupied on the board" do
    it "returns nil when asking for box 0,0 given an empty board" do
      result = @board.empty_box(0,0)
      expect(result).to eq(nil)
    end
  end

end
