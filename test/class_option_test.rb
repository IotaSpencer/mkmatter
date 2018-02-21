require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/mkmatter'
describe Mkmatter do
  it ':__print_version' do
    version  = Mkmatter::VERSION
    app      = Mkmatter::App::CLI.new
    out, err = capture_io do
      app.invoke(:__print_version)
    end
    assert_match(version + "\n", out)
  end
  it ':__debug' do
    app = Mkmatter::App::CLI.new
    
    assert_output(nil, '') {
      app.invoke(:__debug)
    }
  
  end
end
