require_relative 'board'
require_relative 'player'

class Minesweeper

  def initialize(board = Board.new, player = Player.generate)
    @board = board
    @player = player
  end

  def run
    until @lost
      @board.render
      puts "Choose a square: (ex. 5, 4)"
      coordinates = @player.get_coordinates
      puts "Would you like to flag or reveal?: (r/f)"
      choice = @player.get_choice
      make_move(coordinates, choice)
      system("clear")
    end
    @board.render
    p "#{@player.name}, you lose!"
  end

  private

  def make_move(pos, action)
    if action == "r"
      if @board[pos].is_bomb?
        @lost = true
        @board[pos].reveal
      else
        @board.chain_reveal(pos)
      end
    else
      @board[pos].toggle_flag
    end
  end

end

game = Minesweeper.new
game.run
