module Rupee
  class DayCount
    # Actual/365
    ACT_365 = DayCount.new "Actual/365" do |from, to|
      (to - from) / 365.0
    end
  end
end
