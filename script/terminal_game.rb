require_relative '../tic_tac_toe'

module TicTacToe
  class TerminalGame
    def self.play
      intro = <<-EOF

XOXOXOXOXOXOXOXOXOXOXOXOXOXOX
-- WELCOME TO TIC TAC TOE! --
XOXOXOXOXOXOXOXOXOXOXOXOXOXOX

help for helpful info
quit to terminate
Good luck!
      
      EOF
      puts intro
      puts "Number of Players (0, 1, 2)?"
      begin
        input = gets.chomp
        Game.new(num_players: input.to_i).play
      rescue Game::InvalidNumberOfPlayers => e
        puts e.message
        retry
      end
    end
  end
end

TicTacToe::TerminalGame.play
