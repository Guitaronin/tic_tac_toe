module TicTacToe
  class Game
    attr_accessor :player, :current_input
    attr_reader :board, :monitor, :players, :printer
    def initialize(opts={})
      @board   = Board.new
      num_players = opts.fetch(:num_players, 1)
      build_players(num_players)
      @player  = players.first
      @monitor = opts.fetch(:game_monitor, GameMonitor.new(self))
      @printer = opts.fetch(:printer, Printer.new(self))
    end      
  
    def play
      intro
      
      while playable?
        process_input
        update
        render
      end
      
      end_game
    end
    
    def next_player
      self.player = player == players.first ? players.last : players.first
    end
    
    def print(text)
      printer.print(text)
    end
    
    def set(x, y, value)
      board.set(x, y, value)
    end
    
    
    def self.play(opts={})
      self.new(opts).play
    end
    
        
    private
    
    def process_input
      prompt
      get_input
    end
    
    def prompt
      player.prompt
    end
    
    def get_input
      self.current_input = player.play
    end
    
    def update
      current_input.exec
      clear_input
      return board
    end
    
    def clear_input
      self.current_input = nil
    end
      
    def render
      printer.print_board
    end
    alias_method :intro, :render
    
    def end_game
      render
      
      if monitor.winner?
        print("#{monitor.winner} is the winner!")
      else
        print("There is no winner.")
      end
    end
    
    def playable?
      monitor.playable?
    end
    
    def build_players(num_players)
      @players = case num_players
      when 0
        [1, 2].map { |id| AIPlayer.new(id, self) }
      when 1
        [Player.new(1, self), AIPlayer.new(2, self)]
      when 2
        [1, 2].map { |id| Player.new(id, self) }
      else
        raise InvalidNumberOfPlayers
      end
    end
    
    class InvalidNumberOfPlayers < StandardError
      def message
        "number of players must be 0, 1, or 2"
      end
    end
  end # Game
end
