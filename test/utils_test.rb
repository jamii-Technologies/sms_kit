require 'helper'

class Foo; end

class UtilsTest < Minitest::Test

  def test_register
    SmsKit.register foo: Foo
    assert_equal Foo, SmsKit.providers[:foo]
  end

end