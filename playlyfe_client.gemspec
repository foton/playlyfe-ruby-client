# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'playlyfe_client/version'

Gem::Specification.new do |spec|
  spec.name          = "playlyfe_client"
  spec.version       = PlaylyfeClient::VERSION
  spec.authors       = ["Foton"]
  spec.email         = ["foton@centrum.cz"]
  spec.summary       = "Ruby client to connect to Playlyfe.com game."
  spec.description   = "Ruby client to connect to Playlyfe.com game and play actions from game."
  spec.homepage      = 'https://github.com/foton/playlyfe-ruby-client'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "jwt"
  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters" 
  spec.add_development_dependency "pry" 
end
