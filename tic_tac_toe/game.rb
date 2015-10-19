module TicTacToe
  class Game
    attr_accessor :player
    attr_reader :board, :monitor, :players, :printer
    def initialize(opts={})
      @board = Board.new
      @players = [1, 2].map { |id| Player.new(id) }
      @player  = players.first
      @monitor = GameMonitor.new(self)
      @printer = opts.fetch(:printer, Printer.new(self))
    end
  
    def play
      while playable?
        render
        prompt
        selection = gets.chomp
        if selection =~ /\d\d/
          coordinates = selection.split(//).map { |s| s.to_i }
          begin
            board.set(*coordinates, player.id)
          rescue TicTacToe::Board::TileValueSet
            handle_already_taken(selection)
            next
          end
          next_player
        elsif selection == 'help'
          help
          next
        elsif selection == 'quit'
          quit
          break
        else
          handle_invalid_entry(selection)
          next
        end
      end
      
      end_game
    end
    
    def end_game
      render
      
      if monitor.winner?
        printer.print("#{monitor.winner} is the winner!")
      else
        printer.print("There is no winner.")
      end
    end
    
    def next_player
      self.player = player == players.first ? players.last : players.first
    end
    
    def playable?
      monitor.playable?
    end
    
    def prompt
      printer.print("#{player}, choose a tile")
    end
  
    def render
      printer.print_board
    end
    
    def handle_already_taken(entry)
      print("#{entry} already taken. Try again.")
    end
    
    def handle_invalid_entry(entry)
      print("#{entry.inspect} is not a valid entry. Try 'help'.")
    end
    
    def quit
      print("good bye")
    end
    
    def help
      print("Enter xy grid coordinates (e.g. 01) on your turn.")
      print(printer.template)
    end
    
    
    private
    
    def print(text)
      printer.print(text)
    end
    
  end # Game
end
