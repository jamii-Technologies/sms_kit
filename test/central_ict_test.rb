require 'helper'
require 'sms_kit/providers/central_ict'

SmsKit::CentralICT.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class CentralICTTest < MiniTest::Test

    def text_message
      { text: 'foo bar', to: 12345 }
    end

    def test_params
      message = CentralICT.new text_message
      assert_equal text_message[:to], message.params[:dst]
      assert_equal CentralICT.config.sender, message.params[:src]
      assert_equal text_message[:text], message.params[:body]
      assert_equal 'message_sender', message.params[:call]
      assert_equal 'SMS', message.params[:type]
    end

    def test_deliver
      VCR.use_cassette 'central_ict/success' do
        assert CentralICT.deliver text_message
      end
    end

    def test_deliver_fails
      VCR.use_cassette 'central_ict/failure' do
        assert ! CentralICT.deliver, "Mobimex delivery should have failed"
      end
    end

  end
end
