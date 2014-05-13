require 'helper'

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

end