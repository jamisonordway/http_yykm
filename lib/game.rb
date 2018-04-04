class Game
  attr_reader :guess,
              :random_number,
              :guess_count

  def initialize
    @guess = nil 
    @random_number = rand(0..100)
    @guess_count = 0
  end

end
