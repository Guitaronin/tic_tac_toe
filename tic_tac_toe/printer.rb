module TicTacToe
  class Printer
    attr_reader :game
    def initialize(game)
      @game = game
    end
    
    def print(text)
      puts text
    end
    
    def print_board
      t = template
      tiles.each do |tile|
        t.sub!(tile.coordinates, tile.value)
      end
      puts t
    end
    
    def tiles
      game.board.tiles.map { |t| TilePresenter.new(t) }
    end
    
    def template
      t = <<-EOF
      
      00|10|20
      01|11|21
      02|12|22
      
      EOF
    end
    
    class TilePresenter
      attr_reader :tile
      def initialize(tile)
        @tile = tile
      end
      
      def coordinates
        [tile.x, tile.y].join
      end
      
      def value
        case tile.value
        when 1
          'X'
        when 2
          'O'
        when nil
          '_'
        end
      end
    end # TilePresenter
        
  end # Printer
end
