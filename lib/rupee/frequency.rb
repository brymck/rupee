module Rupee
  # A frequency
  class Frequency
    # The amount of units
    attr :amount
    # The units in which to count (<tt>:days</tt>, <tt>:months</tt>,
    # <tt>:years</tt>, etc.
    attr :unit

    # Creates a new frequency object
    def initialize(amount, unit)
      @amount = amount
      @unit = unit
    end

    def build(from, to)
      results = []
      temp = from
      multiplier = 1

      case @unit
      when :day, :days
        while temp < to
          temp += @amount
          results << temp
        end
      when :week, :weeks
        while temp < to
          temp += @amount * 7
          results << temp
        end
      when :month, :months
        while temp < to
          temp = from.next_month(@amount * multiplier)
          multiplier += 1
          results << temp
        end
      when :year, :years
        while temp < to
          temp = from.next_year(@amount * multiplier)
          multiplier += 1
          results << temp
        end
      end

      results
    end
  end
end
