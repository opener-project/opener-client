# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opener/webservice/version'

Gem::Specification.new do |spec|
  spec.name          = "opener-webservice"
  spec.version       = Opener::Webservice::VERSION
  spec.authors       = ["Wilco van Duinkerken"]
  spec.email         = ["wilcovanduinkerken@olery.com"]
  spec.summary       = %q{A helper gem to make use of OpeNER webservices}
  spec.description   = spec.summary
  spec.homepage      = "http://opener-project.github.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'httpclient'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
