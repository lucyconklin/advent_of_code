require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative 'dec_2'
require_relative 'dec_2_data'

class CoursePlannerTest < Minitest::Test 
  def test_sample_input
    course_planner = CoursePlanner.new(SAMPLE_INPUT)
    assert_equal [15,10], course_planner.final_position
    assert_equal 150, course_planner.position_product
  end
  
  def test_short_input
    course_planner = CoursePlanner.new(SHORT_INPUT)
    assert_equal 392, course_planner.position_product
    assert_equal [14,28], course_planner.final_position
  end
  
  def test_full_input
    course_planner = CoursePlanner.new(FULL_INPUT)
    assert_equal 2187380, course_planner.position_product
    assert_equal [1790, 1222], course_planner.final_position
  end
  
  def test_sample_input_with_aim
    course_planner = CoursePlanner.new(SAMPLE_INPUT, true)
    assert_equal 900, course_planner.position_product
    assert_equal [15,60], course_planner.final_position
  end
  
  def test_short_input_with_aim
    course_planner = CoursePlanner.new(SHORT_INPUT, true)
    assert_equal 4396, course_planner.position_product
    assert_equal [14,314], course_planner.final_position
  end
  
  def test_full_input_with_aim
    course_planner = CoursePlanner.new(FULL_INPUT, true)
    assert_equal 4396, course_planner.position_product
    assert_equal [14,314], course_planner.final_position
  end
end