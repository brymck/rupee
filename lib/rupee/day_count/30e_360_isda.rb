module Rupee
  class DayCount
    # 30E/360 ISDA, typical for Eurobonds
    THIRTY_E_360_ISDA = DayCount.new "30E/360 ISDA" do |from, to|
      d1 = from.day
      d2 = to.day
      d1 = 30 if end_of_month?(from)
      d2 = 30 if end_of_month?(to) # && (d2 != maturity_date || to.month != 2)

      (360 * (to.year - from.year) + 30 * (to.month - from.month) +
        (d2 - d1)) / 360.0
    end
  end
end
