# frozen_string_literal: true

# Houses the general game logic and methods
module GameLogic
  

  def compare_guess(code, guess)
    results = []
    guess.each_with_index do |guess_el, guess_i|
      results.push('☑') if code[guess_i] == guess[guess_i]
      results.push('☒') unless code.include?(guess_el)
      unless code.count(guess_el) < guess.count(guess_el)
        results.push('☐') if code[guess_i] != guess[guess_i]
      end
    end
    results.join(' ')
  end
end
