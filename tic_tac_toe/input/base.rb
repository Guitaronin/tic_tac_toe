module TicTacToe
  class Input::Base
    attr_reader :value, :game
    def initialize(value, game)
      @value = value
      @game  = game
    end
    
    def exec
      raise 'undefined'
    end
  end
end

