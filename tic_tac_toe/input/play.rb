module TicTacToe
  class Input::Play < Input::Base
    def exec
      begin
        game.set(*coordinates, player.id)
        game.next_player
      rescue TicTacToe::Board::TileValueSet
        handle_already_taken
      rescue TicTacToe::Board::OutOfBounds
        handle_out_of_bounds
      rescue TicTacToe::Input::Play::Unparsable
        handle_unparsable
      end
    end
    
    private
        
    def board
      game.board
    end
    
    def coordinates
      raise Unparsable unless two_digit_chars?
      value.split(//).map { |s| s.to_i }
    end
    
    def handle_already_taken
      print("#{value} already taken. Try again.")
    end
    
    def handle_out_of_bounds
      print("coordinates #{coordinates.inspect} do not exist on the board. Try again.")
    end
    
    def handle_unparsable
      print("#{value.inspect} is not a valid entry. Try 'help'.")
    end
    
    def player
      game.player
    end
    
    def print(text)
      game.print(text)
    end
    
    def two_digit_chars?
      !!(value =~ /[0-9]{2}/)
    end
    
    class Unparsable < StandardError; end
  end
end
