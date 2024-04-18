# frozen_string_literal: true

require_relative './game'

# Defines when the computer is trying to crack the code
class ComputerSolver < Game
  def initialize
    super
    @possibilities = @colors
    @correct_colors = nil
  end

  # rubocop:disable Metrics/MethodLength
  def human_code_maker(first_text: true)
    puts 'As the code maker, please enter your choices for the code.' if first_text
    code = color_input
    choice = code.join(' ')
    puts "To confirm, is this the code you want the computer to try and solve? Respond with either Y or N.
    \n\s\s\s\s#{choice}\u001b[0m\n"
    answer = gets.chomp.downcase
    case answer
    when 'y', 'ye', 'yes'
      puts 'Great! The game will now start.'
      choice
    else
      puts "Okay, let's try that again..."
      human_code_maker(first_text: false)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def generate_guess(saved_colors = nil)
    guess = @possibilities.values.sample(4)
    return guess unless saved_colors.is_a?(Hash)

    saved_colors.each do |key, value|
      guess[key.to_i] = value
    end
    guess
  end

  def check_correctness(guess, results)
    results_arr = results.split(' ')
    guess.each_with_index do |element, index|
      @possibilities.delete(@possibilities.key(element)) if results_arr[index] == '☒'
      @correct_colors = {} if @correct_colors.nil?
      @correct_colors[index] = element if results_arr[index] == '☑'
    end
    puts "
    Correct colors are: #{@correct_colors}
    And possibilities are: #{@possibilities}"
  end
end
