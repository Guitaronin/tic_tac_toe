require 'minitest'
require "minitest/autorun"
require_relative '../tic_tac_toe'

module TicTacToe
  class TestTicTacToe < Minitest::Test; end

  class TestAIPLayer < Minitest::Test
    def setup
      @game      = Game.new
      @opponent  = @game.players.first
      @ai_player = @game.players.last
    end
    
    def set_opponent_moves(x, y)
      @game.set(x, y, @opponent.id)
    end
    
    def set_ai_moves(x, y)
      @game.set(x, y, @ai_player.id)
    end
    
    def test_it_finds_a_win
      [[0,0], [0,1]].each { |c| set_ai_moves(*c) }
      assert_equal [0,2], @ai_player.send(:win).coordinates
    end
    
    def test_it_blocks_opponent_win
      [[0,0], [0,1]].each { |c| set_opponent_moves(*c) }
      assert_equal [0,2], @ai_player.send(:block_win).coordinates
    end
    
    def test_it_finds_fork_move
      [[0,0], [2,2]].each { |c| set_ai_moves(*c) }
      # X|_|_
      # _|_|_
      # _|_|X
      assert_includes [[2,0], [0,2]], @ai_player.send(:fork).coordinates
    end
    
    def test_it_blocks_opponent_fork_move
      [[0,0], [2,2]].each { |c| set_opponent_moves(*c) }
      assert_includes [[2,0], [0,2]], @ai_player.send(:block_fork).coordinates
    end
    
    def test_it_plays_center
      assert_equal [1,1], @ai_player.send(:center).coordinates
    end
    
    def test_it_plays_opposite_corner
      set_ai_moves(1,1)
      set_opponent_moves(0,0)
      assert_equal [2,2], @ai_player.send(:opposite_corner).coordinates
    end
    
    def test_it_plays_empty_corner
      set_opponent_moves(1,1)
      set_opponent_moves(2,2)
      set_ai_moves(0,0)
      # O|_|_
      # _|X|_
      # _|_|X
      
      assert_includes [[2,0], [0,2]], @ai_player.send(:empty_corner).coordinates
    end
    
    def test_it_plays_empty_side
      [[0,0], [2,0], [0,2]].each { |c| set_opponent_moves(*c) }
      [[1,1], [2,2]].each { |c| set_ai_moves(*c) }
      # X|_|X
      # _|O|_
      # X|_|O
      
      assert_includes [[1,0], [0,1], [2,1], [1,2]], @ai_player.send(:empty_side).coordinates
    end
  end

  class TestBoard < Minitest::Test
    def setup
      @board = Board.new
    end
    
    def test_it_sets_tile
      @board.set(0,0,1)
      assert_equal 1, @board.tile(0,0).value
    end
    
    def test_it_finds_tile
      assert_equal [2,2], @board.tile(2,2).coordinates
    end
  end

  class TestGameMonitor < Minitest::Test
    def setup
      @game = Game.new
      @game_monitor = @game.monitor
    end
    
    def test_it_detects_win
      [[0,0], [1,0], [2,0]].each { |c| @game.set(*c, 1) }
      assert @game_monitor.winner?
    end
    
    def test_it_detects_draw
      @game.board.tiles.each { |t| t.value = 1 }
      refute @game_monitor.playable?
    end
    
    def test_it_selects_winner
      [[0,0], [1,0], [2,0]].each { |c| @game.set(*c, 1) }
      assert_equal @game.players.first, @game_monitor.winner
    end
  end

  class TestGame < Minitest::Test
    def setup
      @game = Game.new
    end
    
    def test_it_toggles_player
      start_player = @game.player
      @game.next_player
      refute_equal start_player, @game.player
    end
  end

  class TestInput < Minitest::Test; end

  class TestInput::Base < Minitest::Test; end

  class TestInput::Help < Minitest::Test; end

  class TestInput::Play < Minitest::Test
    def test_it_sets_tile_from_input
      game       = Game.new
      play_input = Input::Play.new('00', game)
      play_input.exec
      assert game.board.tile(0,0)
    end
  end

  class TestInput::Quit < Minitest::Test; end

  class TestPLayer < Minitest::Test; end
  
  class TestPlayersFactory < Minitest::Test; end

  class TestPrinter < Minitest::Test; end

  class TestTile < Minitest::Test; end
end
