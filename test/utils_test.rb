require 'helper'

class Foo; end

class UtilsTest < MiniTest::Test

  def test_register
    SmsKit.register foo: Foo
    assert_equal Foo, SmsKit.providers[:foo]
  end

end