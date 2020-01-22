# loads files from minitest gem
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

# loads files of name 'car' from current director to test
require_relative 'car'

# test subclasses from MiniTest::Test
class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end
  
  # name convention for test methods is test_*
  def test_wheels
    # instantiate object
    # car = Car.new
    # test what should be vs what is
    assert_equal(4, @car.wheels)
  end

  def test_bad_wheels
    skip('boyyyyyy')
    car = Car.new
    assert_equal(3, car.wheels)
  end

  def test_car_exists
    car = Car.new
    assert(car)
  end

  def test_name_is_nil
    car = Car.new
    assert_nil(car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: 'Joey')
    end
  end

  def test_instance_of_car
    car = Car.new
    assert_instance_of(Car, car)
  end

  def test_kind_of_car
    assert_kind_of(Auto, @car)
  end

  def test_includes_car
    car = Car.new
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car) # counts as 2 assertions because calls assert_equal
  end
end