require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/mkmatter/cli/runner'
require 'stringio'
require 'highline'
require 'yaml'

class QuestionsTest < MiniTest::Test
  def setup
    @input    = StringIO.new
    @output   = StringIO.new
    @error = StringIO.new
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
    
  end
  def test_that_page_questions_no_file_and_no_draft_works
    @input << "some title\ny\nsome,tags,here,multi word too\nsome categories here\n1\n2\n"
    @input.rewind
    @questions::Page.new(@terminal).ask
  end
end