module Rupee
  class BusinessDay
    # Modified following business day convention
    MODIFIED_FOLLOWING = BusinessDay.new "Roll to following business day " +
      "unless it's in the next month, then use previous business day" do |date, calendar|
      month = date.month

      while calendar.day_off?(date) && date.month == month
        date += 1
      end

      if date.month != month
        while calendar.day_off?(date)
          date -= 1
        end
      else
        date
      end

      date
    end
  end
end
