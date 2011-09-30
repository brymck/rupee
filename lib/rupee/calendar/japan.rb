module Rupee
  class Calendar
    # The national Japanese calendar
    Japan = Calendar.new("The national Japanese calendar")

    # Weekends
    Japan.has_weekends_off

    # New Year's Day
    Japan.has_day_off_on :ganjitsu do |date|
      date.month == JANUARY && date.day == 1
    end

    # Unofficially, banks and most companies close from December 31 - January 3
    Japan.has_day_off_on :bank_holidays do |date|
      (date.month == JANUARY && date.day <= 3) ||
        (date.month == DECEMBER && date.day == 31)
    end

    # Coming of Age Day
    Japan.has_day_off_on :seijin_no_hi do |date|
      date.month == JANUARY && week_of(date) == 2
    end

    # National Foundation Day
    Japan.has_day_off_on :kenkoku_kinen_no_hi do |date|
      date.month == FEBRUARY && next_monday_if_sunday(date, 11)
    end

    # Vernal Equinox Day
    Japan.has_day_off_on :shunbun do |date|
      date.month == MARCH && date.day == 20
    end

    # Showa Day
    Japan.has_day_off_on :showa_no_hi do |date|
      date.month == APRIL && next_monday_if_sunday(date, 29)
    end

    # Golden Week: Constitution Memorial Day, Greenery Day and Children's # Day, respectively
    Japan.has_day_off_on :golden_week do |date|
      date.month == MAY && (date.day.between?(3, 5) ||
                          ((date.monday? || date.tuesday?) && date.day == 6))
    end

    # Marine Day
    Japan.has_day_off_on :umi_no_hi do |date|
      date.month == JULY && week_of(date) == 3
    end

    # Respect-for-the-Aged Day
    Japan.has_day_off_on :keiro_no_hi do |date|
      date.month == SEPTEMBER && week_of(date) == 3
    end

    # Autumnal Equinox Day
    Japan.has_day_off_on :setsubun do |date|
      date.month == SEPTEMBER && next_monday_if_sunday(date, 23)
    end

    # Health and Sports Day
    Japan.has_day_off_on :taiiku_no_hi do |date|
      date.month == OCTOBER && week_of(date) == 2
    end

    # Culture Day
    Japan.has_day_off_on :bunka_no_hi do |date|
      date.month == NOVEMBER && next_monday_if_sunday(date, 3)
    end

    # Labour Thanksgiving Day
    Japan.has_day_off_on :kinro_kansha_no_hi do |date|
      date.month == NOVEMBER && next_monday_if_sunday(date, 23)
    end

    # Emperor's Birthday
    Japan.has_day_off_on :tenno_tanjobi do |date|
      date.month == DECEMBER && next_monday_if_sunday(date, 23)
    end
  end
end
