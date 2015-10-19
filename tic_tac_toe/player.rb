module TicTacToe
  class Player
    attr_reader :id
    def initialize(id)
      @id = id
    end
    
    def name
      "P#{id}"
    end
    alias_method :to_s, :name
  end
end
