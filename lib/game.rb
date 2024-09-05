# frozen_string_literal: true

require_relative 'guess'
require_relative 'feedback'
require_relative 'board'
require 'colorize'
class Game
  attr_accessor :turn, :win, :code, :player_type, :board

  COLORS = %i[red blue green cyan magenta yellow]

  def initialize(player_type)
    self.player_type = player_type
    self.turn = 1
    self.win = false
    self.code = generate_code
    self.board = Board.new
    print_intro

    board.rows << code
    board.feedback_rows << Guess.new(['', '', '', ''], 0)
    game_flow
  end

  def print_intro
    print 'Guess the code. Colors are '
    print 'red'.colorize(:red)
    print ', '
    print 'blue'.colorize(:blue)
    print ' , '
    print 'green'.colorize(:green)
    print ', '
    print 'cyan'.colorize(:cyan)
    print ', '
    print 'magenta'.colorize(:magenta)
    print ', '
    print 'and '
    print 'yellow.'.colorize(:yellow)
    puts ''
    puts 'Input guesses as four colors delimited by spaces. Input other than the 6 colors will be marked as an incorrect guess.' # rubocop:disable Layout/LineLength
    puts ''
    print 'White feedback indicates a color not present.'
    puts ''
    print 'Yellow '.colorize(:yellow)
    print 'feedback indicates a correct color in the wrong position.'
    puts ''
    print 'Blue '.colorize(:blue)
    print 'feedback indicates a correct color in the correct position.'
    puts ''
    puts ''
    puts 'Good luck!'
  end

  def generate_code
    code_array = []
    code_array << COLORS.sample
    code_array << COLORS.sample
    code_array << COLORS.sample
    code_array << COLORS.sample
    Guess.new(code_array, 0)
  end

  def game_flow
    query_guess
    board.feedback_rows << Feedback.new(board.rows[turn], turn, board.rows[0])
    board.display_board
    return if win

    check_for_win
    self.turn += 1
    game_flow
  end

  def check_for_win
    self.win = true if board.feedback_rows[turn].guess_array.all? :blue
    win_game if win == true
    lose_game if self.turn > 11
  end

  def lose_game
    puts ''
    puts ''
    puts 'You failed to guess the code in 12 turns! You lose!'
    exit
  end

  def win_game
    puts ''
    puts ''
    puts 'You guessed the code! You win!'
    exit
  end

  def query_guess
    puts ''
    puts ''
    puts "Make a guess of four colors delimited by spaces for turn #{turn}"
    g1, g2, g3, g4 = gets.split.map(&:to_sym)
    guess_array = []
    guess_array << g1
    guess_array << g2
    guess_array << g3
    guess_array << g4
    board.rows << Guess.new(guess_array, turn)
  end
end
