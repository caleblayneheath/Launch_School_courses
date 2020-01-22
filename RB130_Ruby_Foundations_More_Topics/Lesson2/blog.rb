require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!



def square_root(value)
  return nil if value < 0
  Math::sqrt(value).round
end

class SquareRootTest < MiniTest::Test
  MiniTest::Test.i_suck_and_my_tests_are_order_dependent!


  def test_input_17_is_4
    assert_equal(4, square_root(17))
  end

  def test_input_24_is_5
    assert_equal(5, square_root(24))
  end

  def test_input_9_is_3
    assert_equal(3, square_root(9))
  end

  def test_neg_is_nil
    assert_nil(square_root(-9))
  end
end