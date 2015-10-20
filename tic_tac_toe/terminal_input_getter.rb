module TicTacToe
  class TerminalInputGetter
    attr_reader :game
    def initialize(game)
      @game = game
    end
    
    def input
      Input.new(gets.chomp, game)
    end
  end
end
