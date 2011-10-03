module Rupee
  class DayCount
    # Actual/360
    ACT_360 = DayCount.new "Actual/360, typical LIBOR convention" do |from, to|
      days(from, to) / 360.0
    end
  end
end
