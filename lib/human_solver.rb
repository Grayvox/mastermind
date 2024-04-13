# frozen_string_literal: true

require_relative './game'

# Defines a human trying to crack the code
class HumanSolver < Game
  attr_accessor :computer_code

  def initialize
    super
    @computer_code = generate_code(@colors)
  end

  def generate_code(options = {})
    options.values.to_a.sample(4)
  end

  def human_guess
    total_guesses = 0
    guess = []
    until total_guesses == 4
      puts "Input the next color in your guess. (#{total_guesses + 1}/4)"
      current_color = gets.chomp.downcase
      check_color = color_check(current_color)
      next guess.push(check_color) && total_guesses += 1 unless check_color == 'Invalid color'

      puts 'Invalid color name. Please try again.'
    end
    guess
  end

  # rubocop:disable Metrics/MethodLength
  def color_check(input)
    case input
    when 'r', 'red'
      @colors[:red]
    when 'g', 'green'
      @colors[:green]
    when 'y', 'yellow'
      @colors[:yellow]
    when 'b', 'blue'
      @colors[:blue]
    when 'p', 'purple'
      @colors[:purple]
    when 'c', 'cyan'
      @colors[:cyan]
    else
      'Invalid color'
    end
  end
  # rubocop:enable Metrics/MethodLength
end
