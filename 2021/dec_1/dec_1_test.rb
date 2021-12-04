require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative 'dec_1'
require_relative 'dec_1_data'

class Dec1Test < Minitest::Test
  def test_two_readings
    skip
    readings = [0,1]
    sweeper = SonarSweeper.new(readings)
    assert_equal 1, sweeper.down_count
  end
  
  def test_short_set
    skip
    readings = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    sweeper = SonarSweeper.new(readings)
    assert_equal 7, sweeper.down_count
  end
  
  def test_all_readings
    readings = ALL_READINGS.split(/\n+/)
    sweeper = SonarSweeper.new(readings)
    assert_equal 1553, sweeper.down_count
  end
  
  def test_window_of_readings_short_set
    skip
    readings = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    sweeper = SonarSweeper.new(readings)
    assert_equal 5, sweeper.down_count_with_window
  end
  
  # 1595 is too low
  def test_window_of_readings_full_set
    readings = ALL_READINGS.split(/\n+/)
    sweeper = SonarSweeper.new(readings)
    result = sweeper.down_count_with_window
    assert_equal 1597, result
  end
end
