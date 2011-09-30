module Rupee
  class Calendar
    # The US Federal Reserve calendar
    US = Calendar.new("The Federal Reserve Calendar")

    # Weekends
    US.has_day_off_when do |date|
      date.saturday? || date.sunday?
    end

    # Mondays
    US.has_day_off_when do |date|
      if date.monday?
        case date.month
        when 1, 2
          # Martin Luther King, Jr.'s Birthday (third Monday of February)
          # Washington's Birthday (third Monday of February)
          date.day.between?(15, 21)
        when 5
          # Memorial Day (last Monday of May)
          date.day.between?(25, 31)
        when 9
          # Labor Day (first Monday of September)
          date.day.between?(1, 7)
        when 10
          # Columbus Day (second Monday of October)
          date.day.between?(8, 14)
        end
      end
    end

    # New Year's Day (January 1)
    US.has_day_off_when do |date|
      date.month == 1 && nearest_weekday(date, 1, :force_monday => true)
    end

    # Independence Day (July 4)
    US.has_day_off_when do |date|
      date.month == 7 && nearest_weekday(date, 4)
    end

    # Veterans Day
    US.has_day_off_when do |date|
      date.month == 11 && nearest_weekday(date, 11)
    end

    # Thanksgiving Day (fourth Thursday of November)
    US.has_day_off_when do |date|
      date.month == 11 && date.thursday? && date.day.between?(22, 28)
    end

    # Christmas Day (December 25)
    US.has_day_off_when do |date|
      date.month == 12 && nearest_weekday(date, 25)
    end
  end
end
