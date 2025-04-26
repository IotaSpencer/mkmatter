require_relative './spec_helper'

RSpec.describe "Test basic 'mkmatter' commands" do
  before(:all) do
    @app = Mkmatter::App::CLI
  end
  it "outputs commands for 'mkmatter help'" do
    expect { @app.start(%w(help)) }.to output(/Commands:/).to_stdout_from_any_process
  end
  it "outputs commands for 'mkmatter help new'" do
    expect { @app.start(%w(help new)) }.to output(/Commands:/).to_stdout_from_any_process
  end
  it "outputs the 'mkmatter' version" do
    expect { @app.start(%w(--version)) }.to output(/#{Mkmatter::VERSION}/).to_stdout_from_any_process
    expect { @app.start(%w(-v)) }.to output(/#{Mkmatter::VERSION}/).to_stdout_from_any_process
  end
  it "outputs 'mkmatter' debug information" do
    expect { @app.start(%w(--debug)) }.to output(/mkmatter Debug Info/).to_stdout_from_any_process
  end
  it "outputs 'mkmatter' contact info" do
    expect { @app.start(%w(--info)) }.to output(/mkmatter Info/).to_stdout_from_any_process
  end
  it "outputs 'mkmatter' contact info in a certain format" do
    expect { @app.start(%w(--info --info-format=yaml)) }.to output(/^---/).to_stdout_from_any_process
  end
  it "outputs an error when a nonexistent command is chosen" do
    expect { @app.start(%w(nope this doesnt exist)) }.to output(/Could not find command ".*"\./).to_stderr_from_any_process
  end
end