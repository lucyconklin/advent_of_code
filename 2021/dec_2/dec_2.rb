class CoursePlanner
  attr_reader :final_position
  
  def initialize(course, aim = false)
    @changes = course.split(/\n/)
    @final_position = [0,0]
    @aim = 0
    aim ? chart_course_with_aim : chart_course
  end
  
  def chart_course
    @changes.map do | change |
      x_or_y, quantity = change.split(" ")
      case x_or_y
      when "forward"
        @final_position[0] += quantity.to_i
      when "down"
        @final_position[1] += quantity.to_i
      when "up"
        @final_position[1] -= quantity.to_i
      end
    end
  end
  
  def position_product
    final_position[0] * final_position[1]
  end
  
  
  def chart_course_with_aim
    @changes.map do | change |
      x_or_y, quantity = change.split(" ")
      case x_or_y
      when "forward"
        @final_position[0] += quantity.to_i
        @final_position[1] += quantity.to_i * @aim
      when "down"
        @aim += quantity.to_i
      when "up"
        @aim -= quantity.to_i
      end
    end
  end
end