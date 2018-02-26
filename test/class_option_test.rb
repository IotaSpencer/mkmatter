require_relative './test_helper'
require 'minitest/autorun'
require 'yaml'
require_relative '../lib/mkmatter'

class MkmatterTest < Minitest::Test
  def setup
    @app = Mkmatter::App::CLI
  end
  def test_that_mkmatter_help_prints_commands
    assert_output(/Commands:/) {
      @app.start(%w(help))
    }
  end
  def test_that_help_new_prints_commands
    assert_output(/Commands:/) {
      @app.start(%w(help new))
    }
  end

  def test_that_version_option_works
    assert_output(/#{Mkmatter::VERSION}/, '') {
      @app.start(%w(--version))
      @app.start(%w(-v))
    }
  end
  def test_that_debug_option_works
    assert_output(/mkmatter Debug Info/, '') {
      @app.start(%w(--debug))
    }
  end
  def test_that_info_option_works
    assert_output(/mkmatter Info/, '') {
      @app.start(%w(--info))
    }
  end
  def test_that_info_option_with_format_works
    assert_output(/^---/, '') {
      @app.start(%w(--info --info-format=yaml))
    }
    
  end
  def test_that_nonexistent_command_errors
    assert_output('', /Could not find command ".*"\./) {
      @app.start(%w(nope this doesnt exist))
    }
  end
end