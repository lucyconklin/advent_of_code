require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative 'dec_3'
require_relative 'dec_3_data'

class PowerConsumptionMonitorTest < Minitest::Test
  def test_one_input
    skip
    input = SINGLE_READING
    pcm = PowerConsumptionMonitor.new(input)
    assert_equal "10110", pcm.gamma_rate
    assert_equal "01001", pcm.epsilon_rate
  end
  
  def test_short_input
    skip
    input = SHORT_INPUT
    pcm = PowerConsumptionMonitor.new(input)
    assert_equal "10110", pcm.gamma_rate
    assert_equal "01001", pcm.epsilon_rate
    assert_equal 198, pcm.power_consumption
  end
  
  def test_full_input
    skip
    input = FULL_INPUT
    pcm = PowerConsumptionMonitor.new(input)
    assert_equal 693486, pcm.power_consumption
  end
  
  def test_life_support_rating_one_input
    input = SINGLE_READING
    pcm = PowerConsumptionMonitor.new(input)
    assert_equal "10110", pcm.oxygen_generator_rating
    assert_equal "10110", pcm.co2_scrubber_rating
    assert_equal 484, pcm.life_support_rating
  end
  
  def test_life_support_rating_short_input
    input = SHORT_INPUT
    pcm = PowerConsumptionMonitor.new(input)
    assert_equal "10111", pcm.oxygen_generator_rating
    assert_equal "01010", pcm.co2_scrubber_rating
    assert_equal 230, pcm.life_support_rating
  end
  
  def test_life_support_rating_full_input
    input = FULL_INPUT
    pcm = PowerConsumptionMonitor.new(input)
    # assert_equal "10111", pcm.oxygen_generator_rating
    # assert_equal "01010", pcm.co2_scrubber_rating
    assert_equal 230, pcm.life_support_rating
  end
end