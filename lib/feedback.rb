require_relative 'guess'

class Feedback < Guess
  def initialize(guess, turn, code_guess) # rubocop:disable Lint/MissingSuper
    self.turn = turn
    self.guess_array = []

    calculate_feedback(guess, code_guess)
  end

  def calculate_feedback(guess, code_guess) # rubocop:disable Metrics/MethodLength
    working_code = code_guess.guess_array.clone
    guess.guess_array.each_with_index do |color, index|
      guess_array << if working_code[0..index].include? color
                       if code_guess.guess_array[index] == color
                         working_code[index] = :white
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
