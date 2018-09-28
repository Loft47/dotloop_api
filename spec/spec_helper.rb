require 'simplecov'
require 'coveralls'
SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.start
require 'bundler/setup'
Bundler.setup

require 'plissken'
require 'pry'
require 'dotloop_api'

RSpec.configure do |conf|
  # include things
end
