require 'colorize'
require_relative 'guess'

class Computer_Player
  attr_accessor :knowledge

  COLORS = %i[red blue green cyan magenta yellow]

  def initialize
    self.knowledge = []
    knowledge[0] = :white
    knowledge[1] = :white
    knowledge[2] = :white
    knowledge[3] = :white
  end

  def process_feedback(feedback, guess)
    feedback.guess_array.each_with_index do |space, index|
      knowledge[index] = guess.guess_array[index] if space == :blue
    end
  end

  def make_guess(turn)
    if turn == 1
      Guess.new(%i[red red red red], 1)
    else
      comp_guess = Guess.new(%i[white white white white], turn)
      knowledge.each_with_index do |space, index|
        comp_guess.guess_array[index] = space if space != :white
      end
      comp_guess.guess_array.each_with_index do |space, index|
        comp_guess.guess_array[index] = COLORS.sample if space == :white
      end
      comp_guess
    end
  end
end
