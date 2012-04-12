require 'rubygems'
require 'bundler/setup'

require 'mobi'
require 'mocha'

RSpec.configure do |config|
  config.mock_with :rr
end