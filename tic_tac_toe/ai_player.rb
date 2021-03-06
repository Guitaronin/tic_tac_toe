# Strategy from http://stackoverflow.com/questions/125557/what-algorithm-for-a-tic-tac-toe-game-can-i-use-to-determine-the-best-move-for
module TicTacToe
  class AIPlayer < Player
    STRATEGIES = [:win, :block_win, :fork, :block_fork, :center, :opposite_corner, :empty_corner, :empty_side]
    # Matching interface for Player
    # and Input, since it's self
    # contained.
    def play
      self
    end
    
    def exec
      game.set(*best_move_coordinates, self.id)
      game.next_player
    end
    
    def prompt
      game.print("#{name} is thinking...")
      # game.print("... best strategy is #{best_strategy} - #{best_move_tile.coordinates}")
    end
    
    private
    
    def board
      game.board
    end
    
    def best_move_coordinates
      best_move_tile.coordinates
    end
    
    def best_move_tile
      win             || 
      block_win       ||
      fork            ||
      block_fork      ||
      center          ||
      opposite_corner ||
      empty_corner    ||
      empty_side
    end
    
    def strategies
      STRATEGIES
    end
    
    def best_strategy
      strategies.find { |s| self.send(s) }
    end
    
    def opponent
      game.players.find { |p| p != self }
    end
    
    def tile_sets
      [:rows, :columns, :diagonals].inject([]) do |sets, orientation|
        board.send(orientation).each do |set|
          sets << set
        end
        sets
      end
    end
    
    def sub_sets(contains, contains_count, empty_count)
      tile_sets.select do |tiles|
        tiles.count { |t| t.value == contains } == contains_count &&
        tiles.count { |t| t.empty? } == empty_count
      end
    end
    
    def winning_tile_for(value)
      target = sub_sets(value, 2, 1).first
      
      if target
        random_empty(target)
      end
    end
      
    def win
      winning_tile_for(self.id)
    end
    
    def block_win
      winning_tile_for(opponent.id)
    end
          
    def fork_tiles_for(value)
      _sub_sets = sub_sets(value, 1, 2)
      
      intersections = _sub_sets.permutation(2).map do |pair|
        pair[0] & pair[1]
      end
      
      intersections.flatten.compact.uniq.select { |t| t.empty? }
    end
    
    def fork
      fork_tiles_for(self.id).sample
    end
    
    def block_fork
      fork_tiles = fork_tiles_for(opponent.id)
      if fork_tiles.any?
        fork_defense_1 ||
        fork_defense_2(fork_tiles)
      end
    end
    
    def fork_defense_1
      _sub_sets = sub_sets(self.id, 1, 2)
      random_empty(_sub_sets)
    end
    
    def fork_defense_2(fork_tiles)
      fork_tiles.sample
    end
    
    def center
      center_tile = board.tile(1, 1)
      center_tile if center_tile.empty?
    end
    
    def opposite_corner
      opponent_corners = board.corners.select { |t| t.value == opponent.id }
      opposite_corners = opponent_corners.map do |tile|
        x = tile.x == 0 ? 2 : 0
        y = tile.y == 0 ? 2 : 0
        board.tile(x, y)
      end
      random_empty(opposite_corners)
    end
    
    def empty_corner
      random_empty(board.corners)
    end
    
    def empty_side
      random_empty(board.sides)
    end
    
    def random_empty(tiles)
      tiles.select { |t| t.empty? }.sample
    end
  end
end
    