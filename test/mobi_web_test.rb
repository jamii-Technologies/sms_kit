require 'helper'

SmsKit::MobiWeb.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class MobiWebTest < MiniTest::Test

    def text_message
      { text: 'foo bar', to: 12345 }
    end

    def test_deliver
      options = { match_requests_on: [
        VCR.request_matchers.uri_without_params(:username, :password)
      ]}

      VCR.use_cassette 'mobi_web_success', options do
        assert_equal 123, MobiWeb.deliver(text_message)
      end

      VCR.use_cassette 'mobi_web_error', options do
        assert_nil MobiWeb.deliver
      end
    end

  end
end
