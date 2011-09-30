module Rupee
  class Calendar
    # The US Federal Reserve calendar
    US = Calendar.new("The Federal Reserve Calendar")

    # Weekends
    US.has_weekends_off

    # Mondays
    US.has_day_off_when do |date|
      if date.monday?
        case date.month
        when JANUARY, FEBRUARY
          # Martin Luther King, Jr.'s Birthday (third Monday of February)
          # Washington's Birthday (third Monday of February)
          week_of(date) == 3
        when MAY
          # Memorial Day (last Monday of May)
          last_week?(date)
        when SEPTEMBER
          # Labor Day (first Monday of September)
          week_of(date) == 1
        when OCTOBER
          # Columbus Day (second Monday of October)
          week_of(date) == 2
        end
      end
    end

    # Fixed holidays
    US.has_day_off_when do |date|
      case date.month
      when JANUARY
        # New Year's Day (January 1)
        next_weekday(date, 1)
      when JULY
        # Independence Day (July 4)
        nearest_weekday(date, 4)
      when NOVEMBER
        # Veterans Day (November 11)
        nearest_weekday(date, 11)
      when DECEMBER
        # Christmas Day (December 25)
        nearest_weekday(date, 25)
      end
    end

    # Thanksgiving Day (fourth Thursday of November)
    US.has_day_off_when do |date|
      date.month == NOVEMBER && date.thursday? && week_of(date) == 4
    end
  end
end
