module TicTacToe
  class Input::Quit < Input::Base
    def exec
      game.print("good bye")
      exit
    end
  end
end

