require_relative './test_helper'
require 'minitest/autorun'
require_relative '../lib/mkmatter'
class DescriptionsTest < MiniTest::Test
  def setup
    @app = Mkmatter::App::CLI
    @descriptions = Mkmatter::App::Descriptions
  end
  
  def teardown
    # Teardown something
  end
  
  def test_new_post_description
    assert_output(/mkmatter new post/, '') {
      @app.start(%w(new help post))
    }
  end
  def test_new_page_description
    assert_output(/mkmatter new page/, '') {
      @app.start(%w(new help page))
    }
  end
end