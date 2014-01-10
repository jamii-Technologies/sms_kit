require 'rubygems'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
# require 'webmock/minitest'
require 'vcr'
require 'sms_kit'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :faraday
end
