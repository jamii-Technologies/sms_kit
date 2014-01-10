require 'helper'

module SmsKit
  module Test
    API_URL = 'http://www.example.com'
    class Message; include SmsKit::Message; end
  end

  register test: Test
end

class MessageTest < MiniTest::Test

  def setup
    @msg = SmsKit::Test::Message.new text: 'foo bar'
  end

  def test_data
    data = @msg.instance_variable_get :@data
    assert_equal 'foo bar', data[:text]
  end

  def test_uri
    assert_kind_of URI, @msg.uri
  end

  def test_connection
    assert_instance_of Faraday::Connection, @msg.connection
  end

  def test_provider_api_url
    assert_equal 'http://www.example.com', @msg._provider_api_url
  end

end
