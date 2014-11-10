# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'artoo-wandboard/version'

Gem::Specification.new do |s|
  s.name        = 'artoo-wandboard'
  s.version     = Artoo::Wandboard::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Dāvis']
  s.email       = ['davispuh@gmail.com']
  s.homepage    = 'https://github.com/davispuh/artoo-wandboard'
  s.license     = 'UNLICENSE'
  s.summary     = %q{Artoo adaptor and driver for Wandboard}
  s.description = %q{Artoo adaptor and driver for Wandboard}

  s.rubyforge_project = 'artoo-wandboard'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'artoo', '>= 1.8.0'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'simplecov'
end
