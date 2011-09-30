module Rupee
  class Calendar
    # The national Japanese calendar
    Japan = Calendar.new("The national Japanese calendar")

    # Weekends
    Japan.has_weekends_off

    # Fixed and solar holidays
    Japan.has_day_off_when do |date|
      case date.month
      when JANUARY
        # New Year's Day
        date.day == 1
      when FEBRUARY
        # National Foundation Day
        date.day == 11
      when MARCH
        # Vernal Equinox Day
        date.day == 20
      when APRIL
        # Showa Day
        date.day == 29
      when MAY
        # Golden Week: Constitution Memorial Day, Greenery Day and Children's
        # Day, respectively
        date.day.between?(3, 5)
      when SEPTEMBER
        # Autumnal Equinox Day
        date.day == 23
      when NOVEMBER
        # Culture Day and Labour Thanksgiving Day
        date.day == 3 || date.day == 23
      when DECEMBER
        # Emperor's Birthday
        date.day == 23
      end
    end

    # Mondays
    Japan.has_day_off_when do |date|
      if date.monday?
        case date.month
        when JANUARY, OCTOBER
          # Coming of Age Day, Health and Sports Day
          week_of(date) == 2
        when JULY, SEPTEMBER
          # Marine Day, Respect-for-the-Aged Day
          week_of(date) == 3
        end
      end
    end
  end
end
