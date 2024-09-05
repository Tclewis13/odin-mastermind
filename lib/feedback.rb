require_relative 'guess'

class Feedback < Guess
  def initialize(guess, turn, code_guess) # rubocop:disable Lint/MissingSuper
    self.turn = turn
    self.guess_array = []

    calculate_feedback(guess, code_guess)
  end

  def calculate_feedback(guess, code_guess) # rubocop:disable Metrics/MethodLength
    guess.guess_array.each_with_index do |color, index|
      guess_array << if code_guess.guess_array.include? color
                       if code_guess.guess_array[index] == color
                         :blue
                       else
                         :yellow
                       end
                     else
                       :white
                     end
    end
  end
end
