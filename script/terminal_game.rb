require_relative '../tic_tac_toe'

module TicTacToe
  class TerminalGame
    attr_accessor :num_players, :player_token
    
    def intro
      puts intro_template
    end
    
    def setup
      get_num_players
      get_player_token
    end
    
    def play
      intro
      setup
      begin
        play = true
        while play
          new_game.play
          play = continue?
        end
        outro
      rescue Game::InvalidNumberOfPlayers => e
        puts e.message
        retry
      end
    end
    
    def self.play
      new.play
    end
    
    private
    
    def continue?
      puts "would you like to play again?"
      !!gets.chomp.match(/^y$|^yes$/i)
    end
    
    def outro
      puts "Game Over"
    end
    
    def new_game
      Game.new(num_players: num_players, player_token: player_token)
    end
    
    def get_num_players
      puts "Number of Players (0, 1, 2)?"
      self.num_players = gets.chomp.to_i
    end
    
    def get_player_token
      if num_players == 1
        puts "X or O?"
        self.player_token = gets.chomp
      end
    end
    
    def intro_template
      <<-EOF

XOXOXOXOXOXOXOXOXOXOXOXOXOXOX
-- WELCOME TO TIC TAC TOE! --
XOXOXOXOXOXOXOXOXOXOXOXOXOXOX

help for helpful info
quit to terminate
Good luck!
      
      EOF
    end
  end
end

TicTacToe::TerminalGame.play
