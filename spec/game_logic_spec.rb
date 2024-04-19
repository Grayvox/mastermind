require 'spec_helper'
require './lib/game_logic'

RSpec.describe 'Game Logic' do
  context 'when given a possible code and a possible guess' do
    it 'compares them and returns the correct results' do
      expect(GameLogic.compare_guess(
        ["\e[31m⬤", "\e[31m⬤", "\e[31m⬤", "\e[31m⬤"],
        ["\e[36m⬤", "\e[31m⬤", "\e[33m⬤", "\e[33m⬤"])
      ).to eq('☒ ☑ ☒ ☒')
    end
  end

  context 'when asked to check if a code and guess are the same' do
    it 'returns false if they are not' do
      expect(GameLogic.correct_guess?(
        ["\e[31m⬤", "\e[31m⬤", "\e[31m⬤", "\e[31m⬤"],
        ["\e[31m⬤", "\e[31m⬤", "\e[31m⬤", "\e[33m⬤"])
      ).to eq(false)
    end
  end
end