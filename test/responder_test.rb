require_relative 'test_helper'
require './lib/responder'

class ResponseTest < Minitest::Test
  attr_reader

  def setup
    @path_root = "/"
    @requests = 0
    @diagnostics_lines = ["Verb: GET",
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
    @header_when_root = ["http/1.1 200 ok",
                         "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                         "server: ruby",
                         "content-type: text/html; charset=iso-8859-1",
                         "content-length: 490\r\n\r\n"].join("\r\n")

  end

  def test_it_takes_in_path
    response = Responder.new(@diagnostics_lines, @path_root, 0, 0)
    result = response.write_output("")

    assert_equal "<html><head></head><body><p>#{@diagnostics_lines.join("<br>")}<br>Number of Requests: #{@requests}</p><h1>""</h1></body></html>", result
  end

  def test_it_writes_correct_output_for_given_root_path
    response = Responder.new(@diagnostics_lines, @path_root, 0, 0)
    result = response.write_output("")

    assert_equal "<html><head></head><body><p>#{@diagnostics_lines.join("<br>")}<br>Number of Requests: #{@requests}</p><h1>""</h1></body></html>", result
  end

  def test_it_writes_correct_output_for_hello_path
    response = Responder.new(@diagnostics_lines, '/hello', 0, 0)
    result = response.write_output("Hello, World")

    assert_equal "<html><head></head><body><p>#{@diagnostics_lines.join("<br>")}<br>Number of Requests: #{@requests}</p><h1>Hello, World</h1></body></html>", result
  end

  def test_it_writes_correct_output_for_datetime_path
    response = Responder.new(@diagnostics_lines, @path_root, 0, 0)
    result = response.write_output("6:21PM on Tuesday, April 3")
    assert_equal "<html><head></head><body><p>#{@diagnostics_lines.join("<br>")}<br>Number of Requests: #{@requests}</p><h1>6:21PM on Tuesday, April 3</h1></body></html>", result
  end

  def test_it_writes_correct_output_for_shutdown_path
    response = Responder.new(@diagnostics_lines, @path_root, 0, 1)
    result = response.write_output("Total Number of Requests 1")

    assert_equal "<html><head></head><body><p>Total Number of Requests 1</p></body></html>", result
  end

  def test_it_determines_which_output_for_given_path
    response = Responder.new(@diagnostics_lines, @path_root, 0, 0)
    output = response.determine_output_from_path
    result = response.write_header(output)
    assert_equal @header_when_root, result
  end

end
