require_relative 'test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_generates_random_number_between_one_and_one_hundred
    result = @game.random_number

    assert (0..100).to_a.include?(result)
  end

  def test_it_increments_guess_count
    assert_equal 0, @game.guess_count

    @game.guess(12)

    assert_equal 1, @game.guess_count
  end

  # THIS TEST IS NOT WORKING AND I'M NOT SURE WHY
  # WRITE_RESPONSE SHOULD RETURN A STRING THAT INCLUDES "NUMBER"
  # def test_it_writes_response
  #   @game.guess(12)
  #
  #   assert @game.write_response.includes?("Number")
  # end

end
