require_relative 'spec_helper'
require_relative '../lib/mkmatter/cli/runner'
require 'rspec/expectations'
require 'io/console'
require 'highline'
require 'highline/test'
require 'yaml'

RSpec.configure do |c|
end


RSpec.describe 'PostQuestionsTest' do
  before(:example) do
    @questions = Mkmatter::Questions

    # Before running a test, create a HighLine::Test::Client
    @client = HighLine::Test::Client.new

    # The application itself is started in a block passed to the #run method
    @client.run do |driver|
      # This block is run in a child process

      # The HighLine instance used by the application *must* be the one supplied by
      # the client.
      expect(Mkmatter::Questions::Post).to receive(:instance_variable_get) do |args|
        expect(args[0]).to eq(:@hl)
      end.and_return(driver.high_line)
      # Do any other setup (e.g. stubbing) here
      # Start the application under test
      # If this block ever completes, the child process will be killed by
      # HighLine::Test
    end

    @front_matter_regex = <<~HEREDOC
      ---\n
      layout\:\s(?<layout_>post|page)\n
      title\:\s(?<title_>[[:print:]]{1,})\n
      categories\:\n
      (?<categories>(?:(?>-\s[[:print:]]{1,})\n){1,})
      tags\:\n
      (?<tags>(?:(?>-\s[[:print:]]{1,})\n){1,})
      date\:\s\'(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})\s
      (?<hour>\d{2})\:(?<minute>\d{2})\:(?<second>\d{2})\s
      [+-]{1}(?<timezone_offset_hour>\d{2})(?<timezone_offset_minute>\d{2})\'\n
      ---
    HEREDOC
  end
  after :example do
    @client.cleanup
  end
  it 'outputs no file, and is not a draft' do
    @qs = @questions::Post.new
    expect { @qs.ask }.to output('Title: ').to_stdout_from_any_process
    expect { @client.type('some title') }.to output("Would you like it 'titleized' (Title instead of title)? ").to_stdout_from_any_process
    expect { @client.type 'y' }.to output("Tags? (write one on each line, then type '.') ").to_stdout_from_any_process
    expect { @client.type "some tags\nwould\ngo\nhere" }.to output("Categories? (write one on each line, then type '. ') ").to_stdout_from_any_process
    expect { @client.type "Some Category\nHere\nUpdates" }.to output("Time Zone? (select by number):\n1. Eastern Time (US & Canada)\n2. Central Time (US & Canada)\n3. neither\n? ").to_stdout_from_any_process
    expect { @client.type '1' }.to output("Choose whether you want HTML or\nMarkdown:\n1. html\n2. md\n? ").to_stdout_from_any_process
    regex = Regexp.new(Regexp.quote(@front_matter_regex), Regexp::EXTENDED)
    expect { @client.type '2' }.to output(regex).to_stdout_from_any_process

  end
  # def test_that_page_questions_no_file_and_no_draft_works
  #   #"some title\ny\nmd\nsome,tags,here,multi word too\nsome categories here\n1\nmd\n"
  #   #@input.rewind
  #   #HighLine::Simulate.with "some title\ny\nmd\nsome,tags,here,multi word too\nsome categories here\n1\nmd\n" do
  #   #  @questions::Page.new(@terminal).ask
  #   #end
  #   #@input = IO.new
  # end
end
