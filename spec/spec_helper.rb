require 'rspec'
require 'mkmatter/cli/app'
require 'custom_formatter'

RSpec.configure do |config|
  config.color      = true
  config.formatter = CustomFormatter


end
