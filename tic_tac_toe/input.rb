module TicTacToe
  class Input
    def self.new(value, game)
      case value.to_s
      when 'help'
        Help.new(game)
      when 'quit'
        Quit.new(game)
      else
        Play.new(value, game)
      end
    end
  end
end
