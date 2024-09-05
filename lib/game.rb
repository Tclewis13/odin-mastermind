# frozen_string_literal: true

require_relative 'guess'
require_relative 'feedback'
require_relative 'board'
require 'colorize'
require_relative 'computer_player'
class Game
  attr_accessor :turn, :win, :code, :player_type, :board

  COLORS = %i[red blue green cyan magenta yellow]

  def initialize(player_type)
    self.player_type = player_type
    self.turn = 1
    self.win = false
    self.board = Board.new

    if player_type == 'codebreaker'
      self.code = generate_code

      print_codebreaker_intro

      board.rows << code
      board.feedback_rows << Guess.new(['', '', '', ''], 0)
      game_flow
    elsif player_type == 'codemaker'
      print_codemaker_intro
      self.code = query_code
      board.rows << code
      board.feedback_rows << Guess.new(['', '', '', ''], 0)
      comp = Computer_Player.new
      codemaker_game_flow(comp)
    end
  end

  def print_codemaker_intro
    print 'Make the code. Colors are '
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
    puts 'Input code as four colors delimited by spaces. Input other than the 6 colors will abort the game.'
  end

  def print_codebreaker_intro
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

  def codebreaker_game_flow
    query_guess
    board.feedback_rows << Feedback.new(board.rows[turn], turn, board.rows[0])
    board.display_board
    return if win

    check_for_win
    self.turn += 1
    codebreaker_game_flow
  end

  def codemaker_game_flow(comp)
    guess = comp.make_guess(turn)
    board.rows << guess
    feedback = Feedback.new(board.rows[turn], turn, board.rows[0])
    board.feedback_rows << feedback
    comp.process_feedback(feedback, guess)

    board.display_board
    return if win

    check_for_win
    self.turn += 1
    codemaker_game_flow(comp)
  end

  def check_for_win
    self.win = true if board.feedback_rows[turn].guess_array.all? :blue
    win_game if win == true
    lose_game if self.turn > 11
  end

  def lose_game
    if player_type == 'codebreaker'
      puts ''
      puts ''
      puts 'You failed to guess the code in 12 turns! You lose!'
      exit
    elsif player_type == 'codemaker'
      puts ''
      puts ''
      puts 'Computer failed to guess the code in 12 turns! You win!'
      exit
    end
  end

  def win_game
    if player_type == 'codebreaker'
      puts ''
      puts ''
      puts 'You guessed the code! You win!'
      exit
    elsif player_type == 'codemaker'
      puts ''
      puts ''
      puts 'Computer guessed the code! You lose!'
      exit
    end
    puts board.rows[0].guess_array
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

  def query_code
    puts ''
    puts ''
    puts 'Input your code.'
    g1, g2, g3, g4 = gets.split.map(&:to_sym)
    guess_array = []
    guess_array << g1
    guess_array << g2
    guess_array << g3
    guess_array << g4
    exit if guess_array.include? :white
    Guess.new(guess_array, turn)
  end
end
