# frozen_string_literal: true

require_relative './text'

# Defines the game itself
class Game
  include Text

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
    
  end
end
