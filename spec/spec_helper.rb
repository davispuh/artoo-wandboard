# encoding: UTF-8
require 'simplecov'
require 'artoo/robot'

Celluloid.logger = nil
Celluloid.shutdown
Celluloid.boot

SimpleCov.start
