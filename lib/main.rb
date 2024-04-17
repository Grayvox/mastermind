# frozen_string_literal: true

require_relative './game'
require_relative './game_logic'
require_relative './text'
require_relative './human_solver'
require_relative './computer_solver'

Game.new.play
