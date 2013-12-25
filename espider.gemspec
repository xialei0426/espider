# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'espider/version'

Gem::Specification.new do |spec|
  spec.name          = "espider"
  spec.version       = ESpider::VERSION
  spec.authors       = ["lei"]
  spec.email         = ["xl_0426@126.com"]
  spec.description   = %q{elong spider}
  spec.summary       = %q{elong spider for qunar,dianyping etc.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  # spec.add_dependency "date"
  spec.add_dependency "nokogiri"
  spec.add_dependency "httparty"
  spec.add_dependency "json"
end
