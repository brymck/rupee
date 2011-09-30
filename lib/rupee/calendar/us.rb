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
        when 1, 2
          # Martin Luther King, Jr.'s Birthday (third Monday of February)
          # Washington's Birthday (third Monday of February)
          week_of(date) == 3
        when 5
          # Memorial Day (last Monday of May)
          last_week?(date)
        when 9
          # Labor Day (first Monday of September)
          week_of(date) == 1
        when 10
          # Columbus Day (second Monday of October)
          week_of(date) == 2
        end
      end
    end

    # Fixed holidays
    US.has_day_off_when do |date|
      case date.month
      when 1
        # New Year's Day (January 1)
        nearest_weekday(date, 1, :force_monday => true)
      when 7
        # Independence Day (July 4)
        nearest_weekday(date, 4)
      when 11
        # Veterans Day (November 11)
        nearest_weekday(date, 11)
      when 12
        # Christmas Day (December 25)
        nearest_weekday(date, 25)
      end
    end

    # Thanksgiving Day (fourth Thursday of November)
    US.has_day_off_when do |date|
      date.month == 11 && date.thursday? && week_of(date) == 4
    end
  end
end
