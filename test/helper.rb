require 'rubygems'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
# require 'webmock/minitest'
require 'vcr'
require 'sms_kit'
require 'logger'

SmsKit.logger = Logger.new '/dev/null'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :faraday
end

class ExampleProvider < SmsKit::Provider
  HTTP_ENDPOINT = 'http://www.example.com'.freeze
end
