module Rupee
  class BusinessDay
    # Previous business day convention
    PREVIOUS = BusinessDay.new "Roll to previous business day" do |date, calendar|
      while calendar.day_off?(date)
        date -= 86_400
      end

      date
    end
  end
end
