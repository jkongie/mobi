require 'rubygems'
require 'bundler/setup'

require 'mobi'
require 'rr'

RSpec.configure do |config|
  config.mock_with :rr
end