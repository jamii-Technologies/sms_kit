require 'helper'
require 'sms_kit/providers/central_ict'

SmsKit::CentralICT.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class CentralICTTest < MiniTest::Test

    def test_deliver
      VCR.use_cassette 'central_ict/success' do
        assert CentralICT.deliver text: 'foo bar', to: 12345
      end
    end

    def test_deliver_fails
      VCR.use_cassette 'central_ict/failure' do
        assert ! CentralICT.deliver, "Mobimex delivery should have failed"
      end
    end

  end
end
