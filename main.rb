require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/feedback'
require_relative 'lib/guess'

puts 'Welcome to Mastermind! Would you like to be the codebreaker or the codemaker?'
puts '1 for codebreaker. 2 for codemaker.'
choice = gets.chomp
choice = choice.to_i

if choice != 1 && choice != 2
  puts 'Why are you being difficult? :( Fine. Dont play.'
  exit
else
  Game.new('codebreaker') if choice == 1
  Game.new('codemaker') if choice == 2
end
