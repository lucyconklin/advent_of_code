class SonarSweeper
  attr_reader :down_count, :down_count_with_window
  
  def initialize(readings)
    @down_count = 0
    @down_count_with_window = 0
    down_counter(readings)
    down_counter_window(readings)
  end
  
  def down_counter(readings)
    @down_count = readings
      .map(&:to_i)
      .each_cons(2)
      .count { |a, b| b > a}
    # readings.each_with_index do |reading, i|
    #   next if i == 0
    #   if reading > readings[i-1]
    #     @down_count += 1
    #   end
    # end
  end
  
  def down_counter_window(readings)
    @down_count_with_window = readings
      .map(&:to_i)
      .each_cons(3)
      .map { |a, b, c| a + b + c }
      .each_cons(2)
      .count { |a, b| b > a }
    # readings.each_with_index do |reading, i|
    #   next if i < 3
    #   if readings[i] > readings[i-3]
    #     @down_count_with_window += 1
    #   end
    # end
  end
end