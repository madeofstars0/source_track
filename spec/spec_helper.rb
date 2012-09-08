require 'source_track'

ENV["RAILS_ENV"] ||= 'test'
ENV["RACK_ENV"]  ||= 'test'

RSpec.configure do |config|
  config.mock_with :rspec 
  config.color_enabled = true
end