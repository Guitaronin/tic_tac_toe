module TicTacToe
  class Board  
    class Tile
      attr_reader :x, :y
      attr_accessor :player, :value
      def initialize(x, y)
        @x, @y = x, y
      end
      
      def coordinates
        [x, y]
      end
      
      def empty?
        value.nil?
      end
    end
  end
end
