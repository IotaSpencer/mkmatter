require 'rspec'
require 'mkmatter'
require 'custom_formatter'

RSpec.configure do |config|
  config.color      = true
  config.formatter = CustomFormatter


end
