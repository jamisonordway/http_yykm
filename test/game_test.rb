require_relative 'test_helper'
require './lib/game.rb'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_generates_random_number_between_one_and_one_hundred
    result = @game.random_number

    assert (0..100).to_a.include?(result)
  end


end
