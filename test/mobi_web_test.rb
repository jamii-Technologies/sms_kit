require 'helper'

SmsKit::MobiWeb.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class MobiWeb::MessageTest < MiniTest::Test

    def setup
      @message = SmsKit::MobiWeb::Message.new to: 12345, text: 'foo bar'
    end

    def test_deliver
      options = { match_requests_on: [
        VCR.request_matchers.uri_without_params(:username, :password)
      ]}

      VCR.use_cassette 'mobi_web_success', options do
        assert_equal 123, @message.deliver.to_i
      end

      VCR.use_cassette 'mobi_web_error', options do
        assert_nil @message.deliver
      end
    end

  end
end
