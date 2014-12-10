require 'helper'

class DeliveryTest < MiniTest::Test

  def test_delivery
    VCR.use_cassette 'mobi_web/quick_deliver' do
      result = SmsKit.deliver to: 123456789, text: 'hello world', provider: :mobi_web
      assert 123, result.to_i
    end
  end

end