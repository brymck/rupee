module Rupee
  class Calendar
    # The US Federal Reserve calendar
    US = Calendar.new("The Federal Reserve Calendar")

    # Weekends
    US.has_weekends_off

    # New Year's Day (January 1)
    US.has_day_off_on :new_years do |date|
      date.month == JANUARY && next_weekday(date, 1)
    end

    # Martin Luther King, Jr.'s Birthday (third Monday of January)
    US.has_day_off_on :mlk_day do |date|
      date.month == JANUARY && date.monday? && week_of(date) == 3
    end

    # Washington's Birthday (third Monday of February)
    US.has_day_off_on :washingtons_day do |date|
      date.month == FEBRUARY && date.monday? && week_of(date) == 3
    end

    # Memorial Day (last Monday of May)
    US.has_day_off_on :memorial_day do |date|
      date.month == MAY && date.monday? && last_week?(date)
    end

    # Independence Day (July 4)
    US.has_day_off_on :independence_day do |date|
      date.month == JULY && nearest_weekday(date, 4)
    end

    # Labor Day (first Monday of September)
    US.has_day_off_on :labor_day do |date|
      date.month == SEPTEMBER && date.monday? && week_of(date) == 1
    end

    # Columbus Day (second Monday of October)
    US.has_day_off_on :columbus_day do |date|
      date.month == OCTOBER && date.monday? && week_of(date) == 2
    end

    # Veterans Day (November 11)
    US.has_day_off_on :veterans_day do |date|
      date.month == NOVEMBER && nearest_weekday(date, 11)
    end

    # Thanksgiving Day (fourth Thursday of November)
    US.has_day_off_on :thanksgiving do |date|
      date.month == NOVEMBER && date.thursday? && week_of(date) == 4
    end

    # Christmas Day (December 25)
    US.has_day_off_on :christmas do |date|
      date.month == DECEMBER && nearest_weekday(date, 25)
    end
  end
end
