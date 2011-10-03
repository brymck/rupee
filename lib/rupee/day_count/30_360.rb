module Rupee
  class DayCount
    # Standard US 30/360
    THIRTY_360 = DayCount.new "30/360, typical pay-fixed convention" do |from, to|
      m1 = from.month
      m2 = to.month
      d1 = from.day
      d2 = to.day

      if end_of_month?(from)
        d1 = 30
        d2 = 30 if m1 == 2 && end_of_month?(to) && m2 == 2
      end

      d2 = 30 if d2 == 31 && d1 == 30

      (360 * (to.year - from.year) + 30 * (m2 - m1) + (d2 - d1)) / 360.0
    end
  end
end
