require 'socket'
require 'pry'

class Parser
  attr_reader :diagnostics,
              :content

  def initialize
    @diagnostics = {"Verb" => nil,
                    "Path" => nil,
                    "Protocol" => nil
                  }
    @content = nil
  end

  def format_request_lines(request_lines)
    split_lines = request_lines[0].split(' ')
    diagnostics["Verb"] = split_lines[0]
    diagnostics["Path"] = split_lines[1]
    diagnostics["Protocol"] = split_lines[2]
    finalize(request_lines)
    request_lines.flatten
  end

  def finalize(request_lines)
    #binding.pry
    diagnostics_format = diagnostics.to_a.map do |line|
      "#{line[0]}: #{line[1]}"
    end
    request_lines[0] = diagnostics_format
  end

end
