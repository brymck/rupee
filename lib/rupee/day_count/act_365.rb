module Rupee
  class DayCount
    # Actual/365
    ACT_365 = DayCount.new "Actual/365" do |from, to|
      days(from, to) / 365.0
    end
  end
end
