# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sms_kit/version'

Gem::Specification.new do |spec|
  spec.name          = "sms_kit"
  spec.version       = SmsKit::VERSION
  spec.authors       = ["glaszig"]
  spec.email         = ["glaszig@gmail.com"]
  spec.summary       = %q{Easily send text messages through SMS over HTTP providers}
  spec.description   = %q{SmsKit offers a streamlined API for sending text messages through any supported provider.}
  spec.homepage      = "https://github.com/jamii-Technologies/sms_kit"
  spec.license       = "MIT"

  spec.files         = Dir['{lib,test}/**/*'] + ['README.md', 'Rakefile']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "base64", "~> 0.2.0"
  spec.add_development_dependency "minitest", "~> 5.13"
  spec.add_development_dependency "webmock", "~> 3.7"
  spec.add_development_dependency "vcr", "~> 5.0.0"
  spec.add_development_dependency "simplecov"

  spec.add_dependency "faraday", "~> 1.0"
end
