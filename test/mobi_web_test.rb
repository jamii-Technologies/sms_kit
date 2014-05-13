require 'helper'

SmsKit::MobiWeb.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class MobiWebTest < MiniTest::Test

    def vcr_options
      { match_requests_on: [
        VCR.request_matchers.uri_without_params(:username, :password)
      ]}
    end

    def text_message
      { text: 'foo bar', to: 12345 }
    end

    def test_deliver
      VCR.use_cassette 'mobi_web_success', vcr_options do
        assert_equal 123, MobiWeb.deliver(text_message)
      end
    end

    def test_error
      VCR.use_cassette 'mobi_web_error', vcr_options do
        provider = MobiWeb.new
        assert_nil provider.deliver
        assert_equal 100, provider.error_code
        assert_equal 'Temporary Internal Server Error. Try again later', provider.error_message
      end
    end

  end
end
