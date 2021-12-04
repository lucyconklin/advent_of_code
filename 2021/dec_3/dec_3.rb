class PowerConsumptionMonitor
  attr_reader :gamma_rate, 
              :epsilon_rate, 
              :oxygen_generator_rating, 
              :co2_scrubber_rating

  def initialize(readings)
    @gamma_rate = ""
    @epsilon_rate = ""
    @readings = readings.split(/\n/)
    find_gamma_rate
    find_epsilon_rate
    
    @oxygen_generator_rating = ""
    @co2_scrubber_rating = ""
    find_oxygen_generator_rating
    find_co2_scrubber_rating
  end

  def find_gamma_rate
    collector = Array.new([])
    @readings.each do |reading|
      reading.split('').each_with_index do |digit, i|
        if !collector[i]
          collector[i] = [digit]
        else
          collector[i] << digit
        end
      end
    end
    @gamma_rate = collector.map do |digits|
      digits.max_by { |i| digits.count(i) }
    end.join('')
  end

  def find_epsilon_rate
    @epsilon_rate = @gamma_rate.split('').map { |digit|  digit ==  "1" ? "0" : "1"}.join('')
  end

  def power_consumption
    @gamma_rate.to_i(2) * @epsilon_rate.to_i(2)
  end
  
  def find_oxygen_generator_rating
    filtered_readings = @readings
    i = 0
    while filtered_readings.length > 1 do
      digits = filtered_readings.map {|r| r[i] }
      zeros = digits.select {|d| d == "0"}.length
      ones = digits.select {|d| d == "1"}.length
      if zeros == ones
        most_common_digit = "1"
      else
        most_common_digit = digits.max_by { |i| digits.count(i) }
      end
      filtered_readings = filtered_readings.select {|reading| reading[i] == most_common_digit}
      i += 1
    end
    @oxygen_generator_rating = filtered_readings[0]
  end
  
  def find_co2_scrubber_rating
    filtered_readings = @readings
    i = 0
    while filtered_readings.length > 1 do
      digits = filtered_readings.map {|r| r[i] }
      zeros = digits.select {|d| d == "0"}.length
      ones = digits.select {|d| d == "1"}.length
      if zeros == ones
        least_common_digit = "0"
      else
        least_common_digit = digits.min_by { |i| digits.count(i) }
      end
      filtered_readings = filtered_readings.select {|reading| reading[i] == least_common_digit}
      i += 1
    end
    @co2_scrubber_rating = filtered_readings[0]
  end
  
  def life_support_rating
    @oxygen_generator_rating.to_i(2) * @co2_scrubber_rating.to_i(2)
  end
end