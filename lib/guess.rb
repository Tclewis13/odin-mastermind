class Guess
  attr_accessor :space_one, :space_two, :space_three, :space_four, :turn

  def initialize(space_one, space_two, space_three, space_four, turn)
    self.space_one = space_one
    self.space_two = space_two
    self.space_three = space_three
    self.space_four = space_four
    self.turn = turn
  end
end
