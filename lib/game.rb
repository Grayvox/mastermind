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

  def color_input
    inputs_given = 0
    all_inputs = []
    until inputs_given == 4
      puts "Input the next color. (#{inputs_given + 1}/4)"
      current_color = gets.chomp.downcase
      check_color = color_check(current_color)
      next all_inputs.push(check_color) && inputs_given += 1 unless check_color == 'Invalid color'

      puts 'Invalid color name. Please try again.'
    end
    all_inputs
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

  def choose_mode(mode, human_name)
    case mode.to_i
    when 1
      puts "You've chosen to play as the code MAKER!"
      puts 'This mode is coming soon!'
    when 2
      puts "You've chosen to play as the code BREAKER!"
      code_breaker = HumanSolver.new
      code = code_breaker.generate_code(@colors)
      code_breaker.human_code_breaker_cycle(code, human_name)
    else
      choose_mode(gets.chomp)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def play(intro: true)
    puts Text.intro_text if intro
    puts 'First, enter your name!'
    human_name = gets.chomp
    puts 'Great! Now pick which gamemode you want to play.
    Say 1 if you want to play as the code MAKER.
    Say 2 if you want to play as the code BREAKER.'
    mode = gets.chomp
    choose_mode(mode, human_name)
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

  def stop_game(winner)
    puts Text.ending_text(winner)
  end
end
