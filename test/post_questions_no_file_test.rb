require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/mkmatter'
require 'stringio'
require 'highline'
require 'yaml'

class PostQuestionsNoFileTest < MiniTest::Test
  def setup
    @input    = StringIO.new
    @output   = StringIO.new
    @terminal = HighLine.new(@input, @output)
    @questions = Mkmatter::Questions
  end
  
  def teardown
    # Teardown something
  end
  
  def test_post_questions
    @input << "some title\ny\nsome,tags,here,multi word too\nsome categories here\n1\n2\n"
    @input.rewind
    @questions::Post.new(@terminal).ask
    
  end
end