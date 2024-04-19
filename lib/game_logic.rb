# frozen_string_literal: true

# Houses the general game logic and methods
module GameLogic
  def self.compare_guess(code, guess)
    results = []
    guess.each_with_index do |guess_el, guess_i|
      next results.push('☑') if code[guess_i] == guess[guess_i]
      next results.push('☒') unless code.include?(guess_el)
      next results.push('☒') if code.count(guess_el) < guess.count(guess_el)

      results.push('☐') if code[guess_i] != guess[guess_i]
    end
    results.join(' ')
  end

  def self.correct_guess?(code, guess)
    code == guess
  end
end
