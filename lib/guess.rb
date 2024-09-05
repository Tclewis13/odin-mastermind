class Guess
  attr_accessor :guess_array, :turn

  def initialize(guess_array, turn)
    self.guess_array = guess_array
    self.turn = turn
  end
end
