module TicTacToe
  class Player
    attr_reader :game, :id, :input_handler
    def initialize(id, game, opts={})
      @id            = id
      @game          = game
      @input_handler = opts.fetch(:input_handler, Input)
    end
    
    def name
      "P#{id}"
    end
    alias_method :to_s, :name
    
    def play
      input_handler.new(gets.chomp, game)
    end
    
    def prompt
      game.print("#{name}, choose a tile")
    end
      
  end
end
