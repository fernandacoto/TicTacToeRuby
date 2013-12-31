require "spec_helper"
describe Players do
  before(:all) do
    @players = Players.new()
  end
  describe "tells which  player play" do
    it "returns 2 given 5 movements and Player One" do 
      result = @players.select_player(5,1)
      expect(result).to eq(2)
    end
  end

  describe "tells if a user select a row/column that does not exist" do
    it "returns true given 3" do
      result = @players.invalid_move?(3)
      expect(result).to eq(true)
    end
  end

  describe "tells if a box is empty" do
    it "returns the cell asked [2,2] given an empty board" do
      result = @players.check_availability([2,2])
      expect(result).to eq([2,2])
    end
  end

end
