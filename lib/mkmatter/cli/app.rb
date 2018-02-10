require 'thor'
require 'mkmatter/cli/methods'
require 'methods'
require 'highline'

class App < Thor
  include Thor::Actions

  map %w[--version -v] => :__print_version

  desc '--version, -v', 'print the version'

  def __print_version
    puts Mkmatter::VERSION
  end
  
  desc 'start', 'run mkmatter'
  def start
    app = Mkmatter::Methods
    app.run
  end
end