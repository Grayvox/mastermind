require 'spec_helper'
require './lib/game'

RSpec.describe 'Game' do
  context 'when asked for color options' do
    it 'returns the correct output' do
      expect(Game.new.colors).to eq({
                                      red: "\e[31m⬤",
                                      green: "\e[32m⬤",
                                      yellow: "\e[33m⬤",
                                      blue: "\e[34m⬤",
                                      purple: "\e[35m⬤",
                                      cyan: "\e[36m⬤"
                                    })
    end
  end
end
