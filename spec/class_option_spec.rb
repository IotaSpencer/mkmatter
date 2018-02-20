require 'rspec'
require 'spec_helper'

RSpec.describe 'mkmatter' do
  specify "  'mkmatter',\n    'mkmatter --help',\n    'mkmatter help',\n    'mkmatter help new'\n  should output commands" do
    expect {system('mkmatter')}.to output(/Commands:.*/).to_stdout_from_any_process
    expect {system('mkmatter --help')}.to output(/Commands:.*/).to_stdout_from_any_process
    expect {system('mkmatter help')}.to output(/Commands:.*/).to_stdout_from_any_process
    expect {system('mkmatter help new')}.to output(/Commands:.*/).to_stdout_from_any_process
  end
  specify "  'mkmatter new help post',\n    'mkmatter new help page',\n  should output usage" do
    expect {system('mkmatter new help post')}.to output(/Usage:.*/).to_stdout_from_any_process
    expect {system('mkmatter new help page')}.to output(/Usage:.*/).to_stdout_from_any_process
  end
end

RSpec.describe 'mkmatter --version' do
  specify 'it should output version' do
    expect do
      system('mkmatter --version')
    end.to output("#{Mkmatter::VERSION}\n").to_stdout_from_any_process
  end
end

RSpec.describe 'mkmatter --info' do
  specify 'it should print table' do
    expect do
      system('mkmatter --info')
    end.to output(/mkmatter Info/).to_stdout_from_any_process
  end
end
RSpec.describe 'mkmatter --debug' do
  specify 'it should print debug list' do
    expect do
      system('mkmatter --debug')
    end.to output(/mkmatter Debug Info/).to_stdout_from_any_process
  end
end