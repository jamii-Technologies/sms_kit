require 'helper'

module TestProvider
  extend SmsKit::Config
end

class ProviderTest < MiniTest::Test

  def test_config
    TestProvider.config.username = 'foo'
    TestProvider.config.password = 'bar'
    TestProvider.config.sender   = 12345

    assert_equal 'foo', TestProvider.config.username
    assert_equal 'bar', TestProvider.config.password
    assert_equal 12345, TestProvider.config.sender
  end

  def test_configure
    TestProvider.configure do |config|
      config.username = 'foo'
      config.password = 'bar'
      config.sender   = 12345
    end

    assert_equal 'foo', TestProvider.config.username
    assert_equal 'bar', TestProvider.config.password
    assert_equal 12345, TestProvider.config.sender
  end

end