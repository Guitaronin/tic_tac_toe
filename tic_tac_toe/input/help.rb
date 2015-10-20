module TicTacToe
  class Input::Help < Input::Base
    def exec
      game.print("Enter xy grid coordinates (e.g. 01) on your turn.")
      game.print(template)
    end
    
    private
    
    def template
      game.printer.template
    end
  end
end

