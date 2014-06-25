require File.expand_path('../lib/opener/client/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "opener-client"
  spec.version     = Opener::Client::VERSION
  spec.authors     = ["Wilco van Duinkerken"]
  spec.email       = ["wilcovanduinkerken@olery.com"]
  spec.summary     = %q{A helper gem to make use of OpeNER webservices}
  spec.description = spec.summary
  spec.homepage    = "http://opener-project.github.com"
  spec.license     = "Apache 2.0"

  spec.files = Dir.glob([
    'lib/**/*',
    'LICENSE.txt',
    '*.gemspec',
    'README.md'
  ]).select { |file| File.file?(file) }

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'httpclient'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
