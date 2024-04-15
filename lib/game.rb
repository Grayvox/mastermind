# frozen_string_literal: true

require_relative './game_logic'
require_relative './text'
require 'pry'
require 'pry-byebug'

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

  def play
    puts Text.intro_text
    p 'Press Enter when you are ready to play. '
    gets.chomp
    current_game = HumanSolver.new
    code = current_game.generate_code(@colors)
    turn_cycle(current_game, code)
  end

  def turn_cycle(mode, code)
    turns_completed = 0
    puts 'Computer has generated the code. Let the game begin!'
    until turns_completed == 12
      puts "Turn #{turns_completed + 1} begins..."
      this_guess = mode.human_guess
      return stop_game if correct_guess?(code, this_guess)

      result = compare_guess(code, this_guess)
      puts Text.results_text(this_guess.join(' '), result, turns_completed)
      turns_completed += 1
    end
  end
end
