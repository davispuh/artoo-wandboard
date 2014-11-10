# encoding: UTF-8
require 'simplecov'
require 'artoo/robot'

Celluloid.logger = nil
Celluloid.shutdown
Celluloid.boot

RSpec.configure do |config|
    config.expect_with :rspec do |c|
        c.syntax = :expect
    end
    config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = true
    end
end

SimpleCov.start

require 'artoo-wandboard'
