# frozen_string_literal: true

require_relative 'guess'
require_relative 'feedback'
require_relative 'board'
class Game
  attr_accessor :turn, :win, :code, :player_type, :board

  COLORS = %i[red blue green cyan magenta yellow]

  def initialize(player_type)
    self.player_type = player_type
    self.turn = 1
    self.win = false
    self.code = generate_code
    self.board = Board.new

    board.rows << code
    board.display_board
  end

  def generate_code
    Guess.new(COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample, 0)
  end
end
