module Rupee
  # An object representing a calendar, for use in determining the next payout
  # date for a cash flow
  class Calendar
    autoload :Japan, "rupee/calendar/japan"
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

    def has_weekends_off
      @days_off << Proc.new do |date|
        date.saturday? || date.sunday?
      end
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

      # Calculates the week of the month in which the given date falls
      def week_of(date)
        (date.day - 1) / 7 + 1
      end

      # Whether the provided date falls in the last week of the month
      def last_week?(date)
        case date.month
        when 9, 4, 6, 11
          # Thirty days hath September
          # April, June and November
          date.day > 23
        when 1, 3, 5, 7, 8, 10, 12
          # All the rest have thirty-one
          date.day > 24
        when 2
          # Save February, with twenty-eight days clear
          # And twenty-nine each leap year ;)
          date.day > (date.year % 4 == 0 && date.year % 100 != 0) ? 22 : 21
        end
      end

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
