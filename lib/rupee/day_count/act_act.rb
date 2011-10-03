module Rupee
  class DayCount
    # Actual/Actual
    ACT_ACT = DayCount.new "Actual/actual" do |from, to|
      1 - from.yday / days_in_year(from) +
        (to.year - from.year - 1) +
        to.yday / days_in_year(to)
    end
  end
end
