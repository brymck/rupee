module Rupee
  class DayCount
    # Standard European 30/360
    THIRTY_E_360 = DayCount.new "30E/360" do |from, to|
      d1 = from.day
      d2 = to.day
      d1 = 30 if d1 == 31
      d2 = 30 if d2 == 31

      (360 * (to.year - from.year) + 30 * (to.month - from.month) +
        (d2 - d1)) / 360.0
    end
  end
end
