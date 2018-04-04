require_relative 'test_helper'
require './lib/word_search'

class WordSearchTest < Minitest::Test
  attr_reader :search

  def setup
    @search = WordSearch.new
  end

  def test_it_stores_parameters
    search.pull_word('/wordsearch?word=this')
    assert_equal 'this', search.word
  end

  def test_it_can_confirm_that_word_is_in_dictionary
    search.pull_word('/wordsearch?word=that')
    assert search.search_in_dictionary
  end

  def test_it_can_refute_that_word_is_in_dictionary
    search.pull_word('/wordsearch?word=brb')
    refute search.search_in_dictionary
  end

  def test_it_can_send_correct_response_after_search
    search.pull_word('/wordsearch?word=pizza')
    result = search.send_correct_response(true)

    assert_equal "PIZZA is a known word", result

    search.pull_word('/wordsearch?word=oizza')
    result = search.send_correct_response(false)

    assert_equal "OIZZA is not a known word", result
  end

end
