require './test/test_helper'

class Responder
  attr_reader :path,
              :diagnostics,
              :header,
              :output,
              :hellos,
              :requests

  def initialize(diagnostics, path, hellos, requests)
    @diagnostics = diagnostics
    @path = path
    @hellos = hellos
    @requests = requests
  end

  def write_output(path_file)
    response = "#{diagnostics.join("<br>")}"
    output = "<html><head></head><body><p>#{response}<br>Number of Requests: #{requests}</p><h1>#{path_file}</h1></body></html>"
  end

  def write_header(output)
    headers = ["http/1.1 200 ok",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def determine_output_from_path
    case path.split('?')[0]
    when '/'
      write_output("")
    when '/hello'
      write_output("Hello, World (#{hellos})")
    when '/datetime'
      write_output("#{Time.now.strftime('%l:%M%p')} on #{Time.now.strftime('%A, %B %d, %Y')}")
    when '/shutdown'
      write_output("Total Number of Requests #{requests}")
    when '/wordsearch'
       found = WordSearch.new.find_word(path)
       write_output(found)
    # when '/start_game'
    #   write_output("Playing Number Guesser")
    else
      write_output("Not a valid path.")
    end
  end

end
