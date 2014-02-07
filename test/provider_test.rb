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

end