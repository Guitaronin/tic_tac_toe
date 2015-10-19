module TicTacToe
  class GameMonitor
    attr_reader :game
    def initialize(game)
      @game = game
    end
    
    def board
      game.board
    end
    
    def sequence
      value_sequence(:rows) || value_sequence(:columns) || value_sequence(:diagonals)
    end
    
    def playable?
      board.empty_tiles? && !winner?
    end
    
    def winner?
      !!sequence
    end
    
    def winner
      return nil unless winner?
      pid = sequence.first.value
      game.players.find { |p| p.id == pid }
    end
    
    private
    
    def value_sequence(orientation)
      collection = self.send(orientation)
      collection.find do |c|
        c.none? { |t| t.empty? } && 
        c.map { |t| t.value }.uniq.length == 1
      end
    end
    
    def rows
      board.rows
    end
    
    def columns
      board.columns
    end
    
    def diagonals
      board.diagonals
    end
  end
end
