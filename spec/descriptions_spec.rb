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
  it "outputs help for new post" do
    expect { @app.start(%w(new help post)) }.to output(/mkmatter new post/).to_stdout
  end
  it 'outputs help for new page' do
  expect { @app.start(%w(new help page)) }.to output(/mkmatter new page/).to_stdout
  end
end