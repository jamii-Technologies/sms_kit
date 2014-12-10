require 'helper'
require 'sms_kit/providers/mobimex'

SmsKit::Mobimex.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class MobimexTest < MiniTest::Test

    def test_deliver
      VCR.use_cassette 'mobimex/success' do
        assert Mobimex.deliver text: 'foo bar', to: 12345
      end
    end

    def test_deliver_fails
      VCR.use_cassette 'mobimex/failure' do
        assert ! Mobimex.deliver, "Mobimex delivery should have failed"
      end
    end

  end
end
