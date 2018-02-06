require 'commander'
require 'mkmatter'
class MyApplication
  include Commander::Methods
  
  def run
    program :name, Mkmatter::__gem_name__
    program :version, Mkmatter::VERSION
    program :description, 'Stupid command that prints foo or bar.'
    
    command :foo do |c|
      c.syntax      = 'foobar foo'
      c.description = 'Displays foo'
      c.action do |args, options|
        say 'foo'
      end
    end
    
    run!
  end
end