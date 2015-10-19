module TicTacToe
  class Game
    attr_accessor :player, :current_input
    attr_reader :board, :monitor, :players, :printer
    def initialize(opts={})
      @board = Board.new
      @players = [1, 2].map { |id| Player.new(id) }
      @player  = players.first
      @monitor = GameMonitor.new(self)
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
    
    def intro
      render
    end
    
    def process_input
      prompt
      self.current_input = gets.chomp
      if current_input == 'help'
        help
      elsif current_input == 'quit'
        quit
      elsif current_input !~ valid_input_pattern
        handle_invalid_entry(selection)
      end
    end
    
    def end_game
      render
      
      if monitor.winner?
        print("#{monitor.winner} is the winner!")
      else
        print("There is no winner.")
      end
    end
    
    def next_player
      self.player = player == players.first ? players.last : players.first
    end
    
    def playable?
      monitor.playable?
    end
    
    def prompt
      print("#{player}, choose a tile")
    end
  
    def render
      printer.print_board
    end
    
    def update
      if current_input =~ valid_input_pattern
        coordinates = current_input.split(//).map { |s| s.to_i }
        begin
          board.set(*coordinates, player.id)
          next_player
        rescue TicTacToe::Board::TileValueSet
          handle_already_taken(current_input)
        end
        current_input = nil
      end
      board
    end
    
    def handle_already_taken(entry)
      print("#{entry} already taken. Try again.")
    end
    
    def handle_invalid_entry(entry)
      print("#{entry.inspect} is not a valid entry. Try 'help'.")
    end
    
    def quit
      print("good bye")
      exit
    end
    
    def help
      print("Enter xy grid coordinates (e.g. 01) on your turn.")
      print(printer.template)
    end
    
    
    private
    
    def print(text)
      printer.print(text)
    end
    
    def valid_input_pattern
      /\d\d/
    end
    
  end # Game
end
