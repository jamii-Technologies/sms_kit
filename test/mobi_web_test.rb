require 'helper'
require 'sms_kit/providers/mobi_web'

SmsKit::MobiWeb.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class MobiWebTest < Minitest::Test

    def vcr_options
      { match_requests_on: [
        VCR.request_matchers.uri_without_params(:username, :password)
      ]}
    end

    def text_message
      { text: 'foo bar', to: 12345 }
    end

    def test_params
      message = MobiWeb.new text_message
      assert_equal text_message[:to], message.params[:phone]
      assert_equal MobiWeb.config.sender, message.params[:originator]
      assert_equal text_message[:text], message.params[:msgtext]
      assert_equal 1, message.params[:showDLR]
    end

    def test_deliver
      VCR.use_cassette 'mobi_web/success', vcr_options do
        assert_equal 123, MobiWeb.deliver(text_message)
      end
    end

    def test_error
      VCR.use_cassette 'mobi_web/failure', vcr_options do
        provider = MobiWeb.new
        error = assert_raises(SmsKit::DeliveryError) { provider.deliver }
        assert_match %r{Temporary Internal Server Error. Try again later \(100\)}, error.message
      end
    end

  end
end
