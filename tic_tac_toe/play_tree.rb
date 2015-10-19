module TicTacToe
  class PlayTree
    class Node
      attr_reader :play, :player, :cell
      def initialize(play, player, cell)
        @play, @player, @cell = play, player, cell
      end
    end
  end
end
