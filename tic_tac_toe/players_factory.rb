module TicTacToe
  class PlayersFactory
    
    attr_reader :num_players, :player1_token, :game
    
    def initialize(num_players, player1_token, game)
      @num_players   = num_players
      @player1_token = player1_token
      @game          = game
      raise InvalidNumPlayers unless valid_opts?
    end
    
    def players
      [player1, player2]
    end
    
    def player1
      @_player1 ||= player(1)
    end
    
    def player2
      @_player2 ||= player(2)
    end
    
    private
    
    def player(id)
      send("player#{id}_ai?") ? new_ai_player(id) : new_player(id)
    end
    
    def valid_opts?
      [0, 1, 2].include? num_players
    end
    
    def player1_ai?
      num_players == 0 || (num_players == 1 && player1_token =~ /^O$/i)
    end
    
    def player2_ai?
      num_players == 0 || (num_players == 1 && !player1_ai?)
    end
    
    def new_player(id)
      Player.new(id, game)
    end
    
    def new_ai_player(id)
      AIPlayer.new(id, game)
    end
    
    class InvalidNumPlayers < StandardError; end
  end
end
