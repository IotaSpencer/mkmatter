require 'mkmatter/common'
require 'mkmatter/questions'
require 'mkmatter/answers'
require 'mkmatter/cli'
require 'mkmatter/version'

require 'active_support/all'
# Main Module Declaration
module Mkmatter

end
class Thor
  module Shell
    class Basic
      def print_wrapped(message, options = {})
        message.lstrip!
        message.gsub!(/\n\s+/, "\n")
        message = message.split("\n")
        message.each do |line|
          line.gsub!(/^------/, '      ') if line[0..5] == '------'
          line.gsub!(/^----/, '    ') if line[0..3] == '----'
          line.gsub!(/^--/, '  ') if line[0..1] == '--'
          stdout.puts line
        end
      end
    end
  end
end