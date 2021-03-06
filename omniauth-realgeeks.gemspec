# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-realgeeks/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["RealGeeks", "Christopher Sass"]
  gem.email         = ["chris@realgeeks.com", "chris@lupinedev.com"]
  gem.description   = %q{Official OmniAuth strategy for RealGeeks.}
  gem.summary       = %q{Official OmniAuth strategy for RealGeeks.}
  gem.homepage      = "https://github.com/RealGeeks/omniauth-realgeeks"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-realgeeks"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::RealGeeks::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', ' 1.3.1'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
