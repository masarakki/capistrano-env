# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/env/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-env"
  spec.version       = Capistrano::Env::VERSION
  spec.authors       = ["masarakki"]
  spec.email         = ["masaki@hisme.net"]
  spec.description   = %q{capistrano with environments}
  spec.summary       = %q{capistrano with environments}
  spec.homepage      = "https://github.com/masarakki/capistrano-env"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.0", "< 5.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "capistrano", '~> 2'
end
