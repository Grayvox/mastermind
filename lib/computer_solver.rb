# frozen_string_literal: true

require_relative './game'

# Defines when the computer is trying to crack the code
class ComputerSolver < Game
  def initialize
    super
    @possibilities = @colors
    @watch_for = {}
    @correct_colors = nil
  end

  # rubocop:disable Metrics/MethodLength
  def computer_code_breaker_cycle(code, human_name)
    turns_completed = 0
    puts 'The human has created the code. Let the game begin!'
    until turns_completed == 12
      puts "Turn #{turns_completed + 1} begins..."
      puts "
      Possibilities: #{@possibilities}
      Watch For: #{@watch_for}
      Correct Colors: #{@correct_colors}
      "
      this_guess = generate_guess(@correct_colors)
      result = compare_guess(code, this_guess)
      puts Text.results_text(this_guess.join(' '), result, turns_completed)
      check_correctness(this_guess, result)
      return stop_game('Computer') if correct_guess?(code, this_guess)

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
    \n\s\s\s\s#{code.join(' ')}\u001b[0m\n"
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

  def generate_guess(saved_colors = nil)
    guess = Array.new(4) { @possibilities.values.sample }
    return guess unless saved_colors.is_a?(Hash)

    guess.each_with_index do |element, index|
      guess[index] = @possibilities.values.sample.to_s if guess[index] == @watch_for["#{element} #{index}"]
    end
    saved_colors.each do |key, value|
      guess[key.to_i] = value
    end
    guess
  end

  def check_correctness(guess, results)
    results_arr = results.split(' ')
    guess.each_with_index do |element, index|
      @watch_for["#{element} #{index}"] = element if results_arr[index] == '☒'
      @correct_colors = {} if @correct_colors.nil?
      @correct_colors[index] = element if results_arr[index] == '☑'
    end
  end
end
