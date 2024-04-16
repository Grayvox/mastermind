# frozen_string_literal: true

require_relative './game_logic'
require_relative './text'

# Defines the game itself
class Game
  include Text
  include GameLogic

  attr_accessor :colors

  def initialize
    @colors = {
      red: "\u001b[31m⬤",
      green: "\u001b[32m⬤",
      yellow: "\u001b[33m⬤",
      blue: "\u001b[34m⬤",
      purple: "\u001b[35m⬤",
      cyan: "\u001b[36m⬤"
    }
  end

  def play(intro: true)
    puts Text.intro_text if intro
    puts 'Alright player, enter your name to begin!'
    human_name = gets.chomp
    current_game = HumanSolver.new
    code = current_game.generate_code(@colors)
    turn_cycle(current_game, code, human_name)
    replay
  end

  def replay
    puts 'Would you like to play again? Respond with either Y or N.'
    answer = gets.chomp.downcase
    case answer
    when 'y', 'yes'
      play(intro: false)
    else
      puts 'Thanks for playing! Bye now!'
    end
  end

  def turn_cycle(mode, code, player_name)
    turns_completed = 0
    puts 'Computer has generated the code. Let the game begin!'
    until turns_completed == 12
      puts "Turn #{turns_completed + 1} begins..."
      this_guess = mode.human_guess
      result = compare_guess(code, this_guess)
      puts Text.results_text(this_guess.join(' '), result, turns_completed)
      return stop_game(player_name) if correct_guess?(code, this_guess)

      turns_completed += 1
    end
    # Add what happens if the player doesn't solve it in 12 turns!
  end

  def stop_game(winner)
    puts Text.ending_text(winner)
  end
end
