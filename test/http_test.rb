require 'helper'

class MockProvider < ExampleProvider
  def connection
    super do |conn|
      conn.headers[:user_agent] = 'custom user agent'
    end
  end
end

class HttpTest < Minitest::Test

  def setup
    @default = ExampleProvider.new
    @mock = MockProvider.new
    @insecure = InsecureProvider.new
  end

  def test_connection_config
    conn = @mock.connection
    assert_equal 'custom user agent', conn.headers[:user_agent]
  end

  def test_default_user_agent
    assert_equal \
      "SmsKit/#{SmsKit::VERSION} (https://rubygems.org/gems/sms_kit)",
      @default.connection.headers[:user_agent]
  end

  def test_insecure_warning
    _, err = capture_io do
      @insecure.connection
    end
    expected = "[SmsKit] Provider 'InsecureProvider' is using an unencrypted connection: http://www.example.com\n"
    assert_equal expected, err
  end

end