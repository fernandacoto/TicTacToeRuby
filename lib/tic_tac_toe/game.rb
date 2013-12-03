require_relative "./console_output.rb"
require_relative "./players.rb"
class Game
  def initialize
    @display = Console_output.new()
    @players = Players.new()
  end

  def start_app
    @display.show_options
    option = gets.to_i
    process_option(option) while option != 4  
    exit
  end

  def process_option(option)
    case option
    when 1
      @display.show_instructions
    when 2
      user_user_game
    when 3
      user_computer_game
    end
    initialize
    start_app
  end

  def user_user_game
    @players.user_user_game
  end

  def user_computer_game
    @players.user_computer_game
  end

end
#game = Game.new()
#game.start_app
