module TicTacToe  
  class Board
    XS = [0, 1, 2]
    YS = [0, 1, 2]
    
    attr_reader :tiles
    def initialize
      @tiles = []
      build_board
    end
    
    def empty_tiles?
      tiles.any? { |t| t.empty? }
    end
    
    def set(x, y, value)
      t = tile(x, y)
      raise TileValueSet if t.value
      t.value = value
    end
    
    def tile(x, y)
      tiles.find { |t| t.x == x && t.y == y }
    end
    
    def rows
      ys.map do |y|
        tiles.select { |t| t.y == y }
      end
    end
    
    def columns
      xs.map do |x|
        tiles.select { |t| t.x == x }
      end
    end
    
    def diagonals
      [[tile(0,0), tile(1,1), tile(2,2)],
      [tile(0,2), tile(1,1), tile(2,0)]]
    end
        
    def build_board
      xs.each do |x|
        ys.each do |y|
          tiles << Tile.new(x, y)
        end
      end
    end
    
    def xs
      XS
    end
    
    def ys
      YS
    end
    
    
    class TileValueSet < StandardError; end
  end # Board
end
