require 'helper'

class DeliveryTest < MiniTest::Test

  def test_delivery
    VCR.use_cassette 'mobi_web/quick_deliver' do
      result = SmsKit.deliver :mobi_web, to: 123456789, text: 'hello world'
      assert 123, result.to_i
    end
  end

  def test_to_sms
    VCR.use_cassette 'stub_provider/success', match_requests_on: [ :uri, :body ] do
      object = StubSms.new

      result = SmsKit.deliver :stub_provider, object
      assert 123, result.to_i
    end
  end

end