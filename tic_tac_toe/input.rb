module TicTacToe
  class Input
    def self.new(value, game)
      case value.to_s
      when 'help'
        Help.new(value, game)
      when 'quit'
        Quit.new(value, game)
      else
        Play.new(value, game)
      end
    end
  end
end
