module Rupee
  class BusinessDay
    # Modified previous business day convention
    MODIFIED_PREVIOUS = BusinessDay.new "Roll to previous business day " +
      "unless it's in the previous month, then use following business day" do |date, calendar|
      month = date.month

      while calendar.day_off?(date) && date.month == month
        date -= 1
      end

      if date.month != month
        while calendar.day_off?(date)
          date += 1
        end
      else
        date
      end

      date
    end
  end
end
