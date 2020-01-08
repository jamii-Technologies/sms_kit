require 'helper'
require 'sms_kit/provider'

class StubProvider < SmsKit::Provider
  HTTP_ENDPOINT = 'https://api.example.com'.freeze

  def deliver options = {}
    response = post data.to_json
    response.status.to_i == 200 ? response.body : false
  end
end

SmsKit.register stub_provider: StubProvider

class ProviderTest < MiniTest::Test

  def test_takes_options
    assert_equal :bar, ExampleProvider.new(foo: :bar).data[:foo]
  end

  def test_deliver_raises
    assert_raises RuntimeError do
      ExampleProvider.new.deliver
    end

    assert_raises RuntimeError do
      ExampleProvider.deliver
    end
  end

  def test_error
    provider = ExampleProvider.new
    provider.instance_variable_set :@error_code, 123
    provider.instance_variable_set :@error_message, 'holy crap'

    assert_equal 123, provider.error_code
    assert_equal 'holy crap', provider.error_message
  end

  def test_to_sms
    VCR.use_cassette 'stub_provider/success', match_requests_on: [ :uri, :body ] do
      object = StubSms.new

      result = StubProvider.deliver object
      assert 123, result.to_i
    end
  end

end