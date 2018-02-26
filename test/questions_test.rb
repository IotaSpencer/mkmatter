require_relative 'test_helper'
require 'minitest/autorun'

require 'stringio'
require 'highline'
require 'yaml'

class QuestionsTest < MiniTest::Test
  def setup
    @input    = StringIO.new
    @output   = StringIO.new
    @terminal = HighLine.new(@input, @output)
    @questions = Mkmatter::Questions
  end
  
  def teardown
    # Teardown something
  end
  
  def test_that_post_questions_no_file_and_no_draft_works
    @input << "some title\ny\nsome,tags,here,multi word too\nsome categories here\n1\n2\n"
    @input.rewind
    @questions::Post.new(@terminal).ask
    
    @input.rewind
    runner1 = Mkmatter::App::Runner.new(%w(new post), @input, @output, $stderr)
    runner1.execute!
  end
end