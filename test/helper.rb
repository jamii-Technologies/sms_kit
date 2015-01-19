
if ENV['COV']
  require 'simplecov'
  SimpleCov.start
end

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

require 'sms_kit/provider'
class ExampleProvider < SmsKit::Provider
  HTTP_ENDPOINT = 'http://www.example.com'.freeze
end
