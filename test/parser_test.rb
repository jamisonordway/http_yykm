require_relative 'test_helper'
require './lib/parser.rb'

class ParserTest < Minitest::Test

  def setup
    @request_lines = ["GET / HTTP/1.1",
                        "Host: localhost:9292",
                        "Connection: keep-alive",
                        "Cache-Control: no-cache",
                        "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36",
                        "Postman-Token: e7c09f0e-dea2-c5cb-b5f4-446d68a44429",
                        "Accept: */*",
                        "Accept-Encoding: gzip, deflate, sdch",
                        "Accept-Language: en-US,en;q=0.8,fr;q=0.6"]
    @expected_diagnostics = ["Verb: GET",
                          "Path: /",
                          "Protocol: HTTP/1.1",
                          "Host: localhost:9292",
                          "Connection: keep-alive",
                          "Cache-Control: no-cache",
                          "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36",
                          "Postman-Token: e7c09f0e-dea2-c5cb-b5f4-446d68a44429",
                          "Accept: */*",
                          "Accept-Encoding: gzip, deflate, sdch",
                          "Accept-Language: en-US,en;q=0.8,fr;q=0.6"]
  end

  def test_it_formats_first_request_line
    parser = Parser.new
    result = parser.format_request_lines(@request_lines)

    assert_equal 'GET', parser.diagnostics["Verb"]
  end

  def test_it_returns_reformatted_array
    parser = Parser.new
    result = parser.format_request_lines(@request_lines)

    assert_equal @expected_diagnostics, result
  end

  def test_parser_can_access_path
    parser = Parser.new
    parser.format_request_lines(@request_lines)
    result = parser.diagnostics["Path"]

    assert_equal "/", result
  end

  def test_finalize_interpolates_lines
    parser = Parser.new
    parser.finalize(@request_lines)
    result = diagnostics_format
  end

end
