require "rupee/mixins/find_instance"

module Rupee
  # A class representing a day count convention used to determine cash flow
  # and accrual dates for fixed income products
  class DayCount
    include FindInstance

    autoload :THIRTY_360,        "rupee/day_count/30_360"
    autoload :THIRTY_E_360,      "rupee/day_count/30e_360"
    autoload :THIRTY_E_360_ISDA, "rupee/day_count/30e_360_isda"
    autoload :THIRTY_E_PLUS_360, "rupee/day_count/30e+_360"
    autoload :ACT_360,           "rupee/day_count/act_360"
    autoload :ACT_365,           "rupee/day_count/act_365"
    autoload :ACT_ACT,           "rupee/day_count/act_act"

    # A description of the day count convention
    attr :description
    # The formula for determining a day count factor (days divided by years)
    attr :block

    # Create a new DayCount object
    def initialize(description, &block)
      @description = description
      @block = block
    end

    def factor(from, to)
      block.call from, to
    end

    class << self
      # The number of seconds in a day (a difference of <tt>1</tt> between two
      # dates in Ruby indicates a difference of one second)
      SECONDS_PER_DAY = 86_400.0

      private

      def days(from, to)
        (to - from) / SECONDS_PER_DAY
      end

      def days_in_year(date)
        if leap_year?(date)
          366.0
        else
          365.0
        end
      end

      def end_of_month?(date)
        case date.month
        when 9, 4, 6, 11
          # Thirty days hath September
          # April, June and November
          date.day == 30
        when 1, 3, 5, 7, 8, 10, 12
          # All the rest have thirty-one
          date.day == 31
        when 2
          # Save February, with twenty-eight days clear
          # And twenty-nine each leap year ;)
          date.day == (date.year % 4 == 0 && (date.year % 100 != 0 || date.year % 400 == 0)) ? 29 : 28
        end
      end

      # Determines whether a date falls during a leap year. Leap years include
      # all years divisible by 4, with the exception of years divisible by 100
      # but not divisible by 400 (got that?). That is, 2004 is a leap year, as is
      # 1904. But while 2000 is a leap year (divisible by 400), 1900 is not
      # (divisible by 100 but not 400).
      def leap_year?(date)  # :doc:
        year = date.year
        year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
      end
    end
  end
end
