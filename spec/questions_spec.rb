require_relative "spec_helper"
require_relative "../lib/mkmatter/cli/runner"
require "rspec/expectations"
require "io/console"
require "highline"
require "yaml"

RSpec.configure do |c|
end

# describe "PostQuestionsTest" do
#   # include Cancun::Highline
#   # include Cancun::Test
#   before(:all) do
#     @app = Mkmatter::App::CLI
#     @input = StringIO.new
#     @output = StringIO.new
#     @hl = HighLine.new(@input, @output)
#     @asker = Mkmatter::Questions
#     @answers = nil
#   end
#   describe "ask" do
#     it "asks for title" do
#       @input << "Test post\ny\ntag1\ntag2\ntag3\n.\ncat1\ncat2\ncat3\n.\n1\ny\nseries\ncustom_string\n.\nposts\nthis is a custom string\ny\nThis is a summary.\nIt will be outputted as a YAML Literal\n.\ny\n_posts/#{Time.now.year}/#{Time.now.month}/\ny"
#       @input.rewind
#       @question_hash = @asker.new(@hl).ask("post", true)
#       @answers = Mkmatter::Answers.new(@question_hash, true, true)
#       expect { @app.start(%w(new --type=post)) }.to output(/Title: \n.*/).to_stdout_from_any_process
#       @input.gets
#       @input.gets
#     end
#   end

#   @front_matter_regex = <<~HEREDOC
#     ---\n
#     layout\:\s(?<layout_>post|page)\n
#     title\:\s(?<title_>[[:print:]]{1,})\n
#     categories\:\n
#     (?<categories>(?:(?>-\s[[:print:]]{1,})\n){1,})
#     tags\:\n
#     (?<tags>(?:(?>-\s[[:print:]]{1,})\n){1,})
#     date\:\s\'(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})\s
#     (?<hour>\d{2})\:(?<minute>\d{2})\:(?<second>\d{2})\s
#     [+-]{1}(?<timezone_offset_hour>\d{2})(?<timezone_offset_minute>\d{2})\'\n
#     ---
#   HEREDOC

#   # after :example do
#   #   @client.cleanup
#   # end

# end
