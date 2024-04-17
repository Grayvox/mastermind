# frozen_string_literal: true

require_relative './game'
require_relative './text'

# Defines a human trying to crack the code
class HumanSolver < Game
  include Text

  def generate_code(options)
    arr = options.values
    arr.sample(4)
  end

  # rubocop:disable Metrics/MethodLength
  def human_code_breaker_cycle(code, player_name)
    turns_completed = 0
    puts 'Computer has generated the code. Let the game begin!'
    until turns_completed == 12
      puts "Turn #{turns_completed + 1} begins..."
      this_guess = color_input
      result = compare_guess(code, this_guess)
      puts Text.results_text(this_guess.join(' '), result, turns_completed)
      return stop_game(player_name) if correct_guess?(code, this_guess)

      turns_completed += 1
    end
    puts Text.reveal_code(code.join(' '))
    stop_game('Computer')
  end
  # rubocop:enable Metrics/MethodLength
end
