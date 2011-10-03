require "rupee/mixins/find_instance"

module Rupee
  # A class representing a day count convention used to determine cash flow
  # and accrual dates for fixed income products
  class DayCount
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

    # Calculates the period in years between the <tt>from</tt> and
    # <tt>true</tt> dates
    def period(from, to)
      block.call from, to
    end

    class << self
      include FindInstance

      private

      def days(from, to)
        to - from
      end

      def days_in_year(date)
        date.leap? ? 366.0 : 365.0
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
          date.day == date.leap? ? 29 : 28
        end
      end
    end
  end
end
