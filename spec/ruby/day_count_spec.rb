describe DayCount do
  before :each do
    @christmas = Date.new(2011, 12, 25)
    @next_february = Date.new(2012, 2, 29)
    @many_mays = Date.new(2015, 5, 31)
    @tolerance = 0.0000001
  end

  describe "30/360" do
    it "should produce a correct day count period" do
      DayCount::THIRTY_360.period(@christmas, @next_february).should be_within(@tolerance).of 64 / 360.0
      DayCount::THIRTY_360.period(@christmas, @many_mays).should be_within(@tolerance).of 1236 / 360.0
    end
  end

  describe "30E/360" do
    it "should produce a correct day count period" do
      DayCount::THIRTY_E_360.period(@christmas, @next_february).should be_within(@tolerance).of 64 / 360.0
      DayCount::THIRTY_E_360.period(@christmas, @many_mays).should be_within(@tolerance).of 1235 / 360.0
    end
  end

  describe "30E+/360" do
    it "should produce a correct day count period" do
      DayCount::THIRTY_E_PLUS_360.period(@christmas, @next_february).should be_within(@tolerance).of 64 / 360.0
      DayCount::THIRTY_E_PLUS_360.period(@christmas, @many_mays).should be_within(@tolerance).of 1236 / 360.0
    end
  end

  describe "Act/360" do
    it "should produce a correct day count period" do
      DayCount::ACT_360.period(@christmas, @next_february).should be_within(@tolerance).of 66 / 360.0
      DayCount::ACT_360.period(@christmas, @many_mays).should be_within(@tolerance).of 1253 / 360.0
    end
  end

  describe "Act/365" do
    it "should produce a correct day count period" do
      DayCount::ACT_365.period(@christmas, @next_february).should be_within(@tolerance).of 66 / 365.0
      DayCount::ACT_365.period(@christmas, @many_mays).should be_within(@tolerance).of 1253 / 365.0
    end
  end

  describe "Act/Act" do
    it "should produce a correct day count period" do
      DayCount::ACT_ACT.period(@christmas, @next_february).should be_within(@tolerance).of 6 / 365.0 + 60 / 366.0
      DayCount::ACT_ACT.period(@christmas, @many_mays).should be_within(@tolerance).of 887 / 365.0 + 1
    end
  end
end
