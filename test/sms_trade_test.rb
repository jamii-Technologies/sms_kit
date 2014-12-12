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

    def test_params
      message = SmsTrade.new text_message
      assert_equal text_message[:to], message.params[:to]
      assert_equal SmsTrade.config.sender, message.params[:from]
      assert_equal text_message[:text], message.params[:message]
      assert_equal SmsTrade::ROUTE_BASIC, message.params[:route]
    end

    def test_deliver
      VCR.use_cassette 'sms_trade/success', vcr_options do
        assert_equal 123456789, SmsTrade.deliver(text_message)
      end
    end

    def test_error
      VCR.use_cassette 'sms_trade/failure', vcr_options do
        provider = SmsTrade.new
        error = assert_raises(SmsKit::DeliveryError) { provider.deliver }
        assert_match /Receiver number not valid \(10\)/, error.message
      end
    end

  end
end
