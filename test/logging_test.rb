require 'helper'
require 'logger'

class MockLogger < Logger; end

class LoggingTest < Minitest::Test

  def teardown
    SmsKit.logger = Logger.new '/dev/null'
  end

  def test_getter
    assert_instance_of Logger, SmsKit.logger
  end

  def test_setter
    SmsKit.logger = MockLogger.new '/dev/null'
    assert_instance_of MockLogger, SmsKit.logger
  end

end