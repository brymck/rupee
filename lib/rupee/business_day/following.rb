module Rupee
  class BusinessDay
    # Following business day convention
    FOLLOWING = BusinessDay.new "Roll to following business day" do |date, calendar|
      while calendar.day_off?(date)
        date += 86_400
      end

      date
    end
  end
end
