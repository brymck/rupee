module Rupee
  # An object representing a calendar, for use in determining the next payout
  # date for a cash flow
  class Calendar
    autoload :US, "rupee/calendar/us"

    # A description of the calendar
    attr :description

    # Builds a calendar
    def initialize(description)
      @description = description
      @days_off = []
    end

    def has_day_off_when(&block)
      @days_off << block
    end

    # Returns true if the specified date is a holiday or day off
    def day_off?(date)
      @days_off.each do |day_off|
        return true if day_off.call(date)
      end

      false
    end

    class << self
      private

      # Calculates whether the provided date is the nearest weekday relative
      # to the provided day of the month
      def nearest_weekday(date, day, opts = {})
        opts = { :force_monday => false }.merge opts

        case date.wday
        when 1     # Monday
          date.day.between?(day, day + (opts[:force_monday] ? 2 : 1))
        when 5     # Friday
          date.day.between?(day - (opts[:force_monday] ? 0 : 1), day)
        when 0, 6  # Weekends
          false
        else       # Tuesday - Thursday
          date.day == day
        end
      end
    end
  end
end
