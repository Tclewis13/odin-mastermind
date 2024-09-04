require 'colorize'

class Board
  attr_accessor :rows, :feedback_rows

  def initialize
    self.rows = []
    self.feedback_rows = []
  end

  def display_board
    rows.each do |row|
      print '[]'.colorize(row.space_one)
      print '[]'.colorize(row.space_two)
      print '[]'.colorize(row.space_three)
      print '[]'.colorize(row.space_four)
    end
  end
end
