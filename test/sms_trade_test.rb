require 'helper'
require 'sms_kit/providers/sms_trade'

SmsKit::SmsTrade.configure do |config|
  config.gateway_key = 'QzXUszXd549ff9f477ka7I'
  config.route       = SmsKit::SmsTrade::ROUTE_BASIC
  config.sender      = 123456
end

module SmsKit
  class SmsTradeTest < MiniTest::Test

    def vcr_options
      { match_requests_on: [ VCR.request_matchers.uri_without_params(:key) ] }
    end

    def text_message
      { text: 'foo bar', to: 12345, debug: 1 }
    end

    def test_deliver
      VCR.use_cassette 'sms_trade_success', vcr_options do
        assert_equal 123456789, SmsTrade.deliver(text_message)
      end
    end

    def test_error
      VCR.use_cassette 'sms_trade_error', vcr_options do
        provider = SmsTrade.new
        assert_nil provider.deliver
        assert_equal 10, provider.error_code
        assert_equal 'Receiver number not valid', provider.error_message
      end
    end

  end
end
