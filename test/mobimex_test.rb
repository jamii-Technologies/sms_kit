require 'helper'
require 'sms_kit/providers/mobimex'

SmsKit::Mobimex.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
  config.route    = SmsKit::Mobimex::ROUTE_AFRICA
end

module SmsKit
  class MobimexTest < Minitest::Test

    def text_message
      { text: 'foo bar', to: 12345, from: 6789 }
    end

    def test_params
      message = Mobimex.new text_message
      assert_equal text_message[:to], message.params[:number]
      assert_equal text_message[:from], message.params[:from_number]
      assert_equal text_message[:text], message.params[:message]
      assert_equal Mobimex::ROUTE_AFRICA, message.params[:route]
    end

    def test_deliver
      VCR.use_cassette 'mobimex/success' do
        assert Mobimex.deliver text_message
      end
    end

    def test_deliver_fails
      VCR.use_cassette 'mobimex/failure' do
        error = assert_raises(SmsKit::DeliveryError) { Mobimex.deliver }
        assert_match %r{Delivery failed}, error.message
      end
    end

  end
end
