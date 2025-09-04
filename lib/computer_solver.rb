# frozen_string_literal: true

require_relative 'game'

# Defines when the computer is trying to crack the code
class ComputerSolver < Game
  def initialize
    super
    @possibilities = @colors
    @correct_colors = nil
    @wrong_spots = {
      0 => [],
      1 => [],
      2 => [],
      3 => []
    }
    @incorrect_colors = []
  end

  # rubocop:disable Metrics/MethodLength
  def computer_code_breaker_cycle(code, human_name)
    turns_completed = 0
    puts 'The human has created the code. Let the game begin!'
    until turns_completed == 12
      puts "Turn #{turns_completed + 1} begins..."
      guess = generate_guess
      result = compare_guess(code, guess)
      puts Text.results_text(guess.join(' '), result, turns_completed)
      check_correctness(guess, result)
      return stop_game('Computer') if correct_guess?(code, guess)

      turns_completed += 1
      sleep(1)
    end
    puts Text.reveal_code(code)
    stop_game(human_name)
  end

  def human_code_maker(first_text: true)
    puts 'As the code maker, please enter your choices for the code.' if first_text
    code = color_input
    puts "To confirm, is this the code you want the computer to try and solve? Respond with either Y or N.
    \n    #{code.join(' ')}\u001b[0m\n"
    answer = gets.chomp.downcase
    case answer
    when 'y', 'ye', 'yes'
      puts 'Great! The game will now start.'
      code
    else
      puts "Okay, let's try that again..."
      human_code_maker(first_text: false)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def generate_guess
    guess = validate_colors
    return guess unless @correct_colors.is_a?(Hash)

    @correct_colors.each do |position, color|
      guess[position.to_i] = color
    end
    guess
  end

  def validate_colors
    result = Array.new(4)
    available_colors = @possibilities.values - @incorrect_colors
    puts 'Available colors:'
    p available_colors
    result.each_with_index do |_, index|
      validate_individual_color(available_colors, result, index)
    end
    result
  end

  def validate_individual_color(available_colors, result, index)
    valid_colors_for_position = available_colors - @wrong_spots[index]
    puts 'Wrong spots:'
    p @wrong_spots

    if valid_colors_for_position.empty?
      puts "Warning: No ideal colors available for position #{index}, using fallback"
      valid_colors_for_position = available_colors
    end

    puts "Valid colors for #{index}:"
    puts valid_colors_for_position
    result[index] = valid_colors_for_position.sample
  end

  def check_correctness(guess, results)
    results_arr = results.split(' ')
    guess.each_with_index do |element, index|
      check_individual_correctness(results_arr, element, index)
    end
  end

  def check_individual_correctness(results, element, index)
    case results[index]
    when '☒' # Completely wrong color
      @incorrect_colors.push(element) unless @incorrect_colors.include?(element)
    when '☐' # Right color, wrong position
      @wrong_spots[index].push(element) unless @wrong_spots[index].include?(element)
    when '☑' # Correct color and position (assuming this is your correct marker)
      @correct_colors = {} if @correct_colors.nil?
      @correct_colors[index] = element
    end
  end
end
