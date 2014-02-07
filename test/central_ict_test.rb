require 'helper'

SmsKit::CentralICT.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end

module SmsKit
  class CentralICTTest < MiniTest::Test

    def test_deliver
      VCR.use_cassette 'central_ict_success' do
        assert CentralICT.deliver text: 'foo bar', to: 12345
      end
    end

    def test_deliver_fails
      VCR.use_cassette 'central_ict_error' do
        assert ! CentralICT.deliver, "Mobimex delivery should have failed"
      end
    end

  end
end
