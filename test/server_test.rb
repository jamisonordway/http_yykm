require 'faraday'
require './lib/server'
require './test/test_helper'

class ServerTest < Minitest::Test

  # Not sure what else to test for server 

  def test_status_starts_at_200
    response = Faraday.get('http://localhost:9292/')
    assert_equal 200, response.status
  end

  def test_diagnostics_are_in_default_body
    response = Faraday.get('http://localhost:9292')
      assert response.body.include?('GET')
  end

  def test_it_follows_path_to_hello
    response = Faraday.get('http://localhost:9292/hello')
    assert response.body.include?("Hello, World")
  end

  def test_it_follows_path_to_datetime
    response = Faraday.get('http://localhost:9292/datetime')
    assert response.body.include?("April")
  end


end
