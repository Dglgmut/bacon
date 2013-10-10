# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bacon/version'

Gem::Specification.new do |spec|
  spec.name          = "bacon"
  spec.version       = Bacon::VERSION
  spec.authors       = ["Dglgmut"]
  spec.email         = ["florez.renan@gmail.com"]
  spec.description   = %q{BACON IS AWESOME}
  spec.summary       = %q{CRISPY BACON}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "em-websocket"
end
