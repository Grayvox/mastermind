# frozen_string_literal: true

# Houses the general game logic and methods
module GameLogic
  def compare_guess(code, guess)
    results = []
    guess.each_with_index do |guess_el, guess_i|
      next results.push('☑') if code[guess_i] == guess[guess_i]
      next results.push('☒') unless code.include?(guess_el)

      results.push('☐')
    end
    results.join(' ')
  end

  def correct_guess?(code, guess)
    code == guess
  end
end
