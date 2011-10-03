module Rupee
  class DayCount
    # 30E+/360
    THIRTY_E_PLUS_360 = DayCount.new "30E+/360" do |from, to|
      m  = to.month - from.month
      d1 = from.day
      d2 = to.day
      d1 = 30 if d1 == 31
      if d2 == 31
        m += 1
        d2 = 1
      end

      (360 * (to.year - from.year) + 30 * m + (d2 - d1)) / 360.0
    end
  end
end
