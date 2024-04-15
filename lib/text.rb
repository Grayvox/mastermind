# frozen_string_literal: true

# Provides the text for the beginning tutorial
module Text
  # rubocop:disable Metrics/MethodLength
  def self.intro_text
    %(
    \u001b[37;41m\n
    ===================
    \s\s\s\s\sMASTERMIND\s\s\s\s
    \s\s\s\s\sBY\sGRAYVOX\s\s\s\s
    ===================
    \u001b[0m

    Welcome to Mastermind, a game about code breaking! There are two game modes - one where you are the
    code MAKER, and the other where you are the code BREAKER.

    Both game modes revolve around the same idea - cracking the code. The code will contain 4 colors
    from the following list:

    \u001b[0m- \u001b[31mRed
    \u001b[0m- \u001b[32mGreen
    \u001b[0m- \u001b[33mYellow
    \u001b[0m- \u001b[34mBlue
    \u001b[0m- \u001b[35mPurple
    \u001b[0m- \u001b[36mCyan
    \u001b[0m
    The code breaker will have 12 turns to crack the code. Each turn, the code breaker can make a guess
    containing 4 colors, no more and no less. The game will then provide feedback based off of the code
    breaker's guesses. In this version of the game, the feedback comes in the form of the following
    possibilities:

    ☒ - \u001b[1mThis symbol indicates the color in it's place
    is not used in the code WHATSOEVER.

    \u001b[0m☐ - \u001b[1mThis symbol indicates the color in it's place
    is used somewhere in the code, but not where the
    guess said it was.

    \u001b[0m☑ - \u001b[1mThis symbol indicates the color in it's place
    is both in the code AND in the correct spot.
    \u001b[0m
    The two options for game mods are either you are the code MAKER or the code BREAKER. Playing as
    the code MAKER is currently not supported, but will be in the future!

    As the code BREAKER, you will be given a code generated by the computer, that follows the
    guidelines laid out earlier, and will have to solve it based off the feedback you get from your
    guesses.

    Have fun! :D
    -Grayvox
    \u001b[37;41m
    \u001b[0m
    )
  end
  # rubocop:enable Metrics/MethodLength

  def self.results_text(guess, results, turn_count)
    %(
              \u001b[1mTurn ##{turn_count + 1}\u001b[0m
         Guess      Results
      _______________________
      | #{guess}\u001b[0m  | #{results}  |
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    )
  end

  def self.ending_text(winner)
    %(
      \s\s\s\s\s\s\u001b[1mGame Over!\u001b[0m
      \s\s\s\s--------------
      #{winner} has won the game!
    )
  end
end
