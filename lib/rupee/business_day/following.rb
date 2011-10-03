module Rupee
  class BusinessDay
    # Following business day convention
    FOLLOWING = BusinessDay.new "Roll to following business day" do |date, calendar|
      while calendar.day_off?(date)
        date += 1
      end

      date
    end
  end
end
