
class Game
  attr_accessor :user_guess,
                :random_number,
                :guess_count

  def initialize
    @user_guess = nil
    @random_number = rand(0..100)
    @guess_count = 0
  end

  def guess(number)
    @user_guess = number
    @guess_count += 1
  end

  def guess_feedback(number)
    if number > @random_number
      "too high."
    elsif number < @random_number
      "too low."
    else
      "correct!"
    end
  end

  def write_response(requests)
    response = "Number of guesses: #{guess_count} <br>Guess:#{user_guess}<br>This guess was #{guess_check}"
    "<html><head></head><body>Number of Requests:#{requests}</p><h1>#{response}</h1></body></html>"
  end
end
