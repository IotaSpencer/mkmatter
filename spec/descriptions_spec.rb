require_relative './spec_helper'
require_relative '../lib/mkmatter'
RSpec.describe "DescriptionsSpec" do
  before do
    @app = Mkmatter::App::CLI
    @descriptions = Mkmatter::App::Descriptions
  end
  
  after do
    # Teardown something
  end

  it 'outputs help for new' do
    expect { @app.start(%w(help new)) }.to output(/Usage:\n  (rspec|mkmatter) new \[options\].*/).to_stdout
  end
end