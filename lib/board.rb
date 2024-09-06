# frozen_string_literal: true

require 'colorize'

class Board
  attr_accessor :rows, :feedback_rows

  def initialize
    self.rows = []
    self.feedback_rows = []
  end

  def display_board
    puts ''
    puts ''
    print 'Guesses'
    print '          '
    print 'Feedback'
    rows.each_with_index do |row, index|
      next if index.zero?

      puts ''
      print '[]'.colorize(row.guess_array[0])
      print '[]'.colorize(row.guess_array[1])
      print '[]'.colorize(row.guess_array[2])
      print '[]'.colorize(row.guess_array[3])

      print '         '
      print '[]'.colorize(feedback_rows[index].guess_array[0])
      print '[]'.colorize(feedback_rows[index].guess_array[1])
      print '[]'.colorize(feedback_rows[index].guess_array[2])
      print '[]'.colorize(feedback_rows[index].guess_array[3])
    end
  end
end
