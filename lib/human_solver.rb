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
end
