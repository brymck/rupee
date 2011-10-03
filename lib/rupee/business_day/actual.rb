module Rupee
  class BusinessDay
    # Actual business day convention
    ACTUAL = BusinessDay.new "Use date even if it's a non-business day" do |date, calendar|
      date
    end
  end
end
