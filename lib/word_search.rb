class WordSearch
  attr_reader :word

  def pull_word(path)
    @word = path.split('=')[1]
  end

  def search_in_dictionary
    file = File.open('/usr/share/dict/words', 'r')
    dictionary = file.readlines.map do |word|
      word.chomp
    end
    dictionary.include?(word)
  end

  def find_word(path)
    pull_word(path)
    found = search_in_dictionary
    #require 'pry', binding.pry
    send_correct_response(found)
  end

  def send_correct_response(found)
    if found == true
      "#{word.upcase} is a known word"
    else
      "#{word.upcase} is not a known word"
    end
  end

end
