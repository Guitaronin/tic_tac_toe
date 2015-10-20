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
      unless xs.include?(x) && ys.include?(y)
        raise OutOfBounds
      end
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
      [ys, ys.reverse].map do |_ys|
        xs.zip(_ys).map { |c| tile(*c) }
      end
    end
    
    def corners
      [
        [xs.min, ys.min],
        [xs.min, ys.max],
        [xs.max, ys.min],
        [xs.max, ys.max]
      ].map do |coordinates|
        tile(*coordinates)
      end
    end
    
    def center
      x = xs.length / 2
      y = ys.length / 2
      tile(x, y)
    end
    
    def sides
      (tiles - corners).delete_if { |t| t == center }
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
    class OutOfBounds  < StandardError; end
  end # Board
end
