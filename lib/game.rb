# frozen_string_literal: true

# Defines the game itself
class Game
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
end