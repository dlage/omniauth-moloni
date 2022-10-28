# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-moloni/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dinis Lage"]
  gem.email         = ["dinis@lage.pw"]
  gem.description   = %q{Unofficial OmniAuth strategy for Moloni.}
  gem.summary       = %q{Unofficial OmniAuth strategy to authenticate against Moloni platform.}
  gem.homepage      = "https://github.com/dlage/omniauth-moloni"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-moloni"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Moloni::VERSION

  gem.add_dependency 'omniauth', '~> 2.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.8'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rack-test', '> 1.0'
  gem.add_development_dependency 'simplecov', '> 0.10.0'
  gem.add_development_dependency 'webmock', '> 2.0'
end
