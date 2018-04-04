require 'socket'
require './lib/parser'
require './lib/responder'

class Server
  attr_reader :tcp_server,
              :parser,
              :request_counter,
              :hello_counter

  def initialize(port)
    @tcp_server = TCPServer.new(9292)
    @parser = Parser.new
    @hello_counter = 0
    @request_counter = 0
  end


  def sequence
    loop do
      client = tcp_server.accept
      diagnostics_list = pull_request_lines(client)
      add_to_counters
      response = Responder.new(diagnostics_list, path, hello_counter, request_counter)
      #game_starter
      output = response.determine_output_from_path
      client.puts response.write_header(output)
      client.puts output
      shutdown?(client)
    end
  end

  def pull_request_lines(client)
    request_lines = []
    line = client.gets
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    @parser.format_request_lines(request_lines)
  end

  def content_length(diagnostics_list)
    content_length = diagnostics_list.find do |line|
      line.include?('Content-Length')
    end
    content_length.split(':')[-1].to_i
  end

  def path
    @parser.diagnostics["Path"]
  end

  def verb
    @parser.diagnostics["Verb"]
  end

  def add_to_counters
    if path == "/hello"
      @hello_counter += 1
      @request_counter += 1
    else
      @request_counter += 1
    end
  end

  # THIS GENERATES A NEW INSTANCE OF THE GAME CLASS, BUT UNTIL I FIGURE
  # OUT HOW TO REDIRECT IT IS USELESS
  def game_starter
    if path == "/start_game"
      @game = Game.new
    end
  end

  #THIS SHOULD TAKE THE USER GUESS AND PASS IT INTO GAME
  # def game_guess
  #   if path == "/game" && verb == "POST"
  #     number = client.read
  #   end
  # end

  def shutdown?(client)
    if path == "/shutdown"
      tcp_server.close
    else
      client.close
    end
  end

 end
