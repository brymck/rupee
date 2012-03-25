describe Calendar do
  def test_calendar(calendar, holidays)
    holidays.each do |holiday|
      year, month, day = holiday
      if calendar.day_off?(Time.new(year, month, day)) == false
        raise "#{year}/#{month}/#{day} is not a holiday"
      end
    end
  end

  describe "for Federal Reserve holidays" do
    before :each do
      @holidays = {
        :new_years        => [[2011,  1 , 1], [2012,  1,  2], [2013,  1,  1], [2014,  1,  1], [2015,  1,  1]],
        :mlk_day          => [[2011,  1, 17], [2012,  1, 16], [2013,  1, 21], [2014,  1, 20], [2015,  1, 19]],
        :washingtons_day  => [[2011,  2, 21], [2012,  2, 20], [2013,  2, 18], [2014,  2, 17], [2015,  2, 16]],
        :memorial_day     => [[2011,  5, 30], [2012,  5, 28], [2013,  5, 27], [2014,  5, 26], [2015,  5, 25]],
        :independence_day => [[2011,  7,  4], [2012,  7,  4], [2013,  7,  4], [2014,  7,  4], [2015,  7,  4]],
        :labor_day        => [[2011,  9,  5], [2012,  9,  3], [2013,  9,  2], [2014,  9,  1], [2015,  9,  7]],
        :columbus_day     => [[2011, 10, 10], [2012, 10,  8], [2013, 10, 14], [2014, 10, 13], [2015, 10, 12]],
        :veterans_day     => [[2011, 11, 11], [2012, 11, 12], [2013, 11, 11], [2014, 11, 11], [2015, 11, 11]],
        :thanksgiving     => [[2011, 11, 24], [2012, 11, 22], [2013, 11, 28], [2014, 11, 27], [2015, 11, 26]],
        :christmas        => [[2011, 12, 26], [2012, 12, 25], [2013, 12, 25], [2014, 12, 25], [2015, 12, 25]]
      }
    end

    it "should be accurate for New Year's Day" do
      test_calendar Calendar::US, @holidays[:new_years]
    end

    it "should be accurate for Martin Luther King's Birthday" do
      test_calendar Calendar::US, @holidays[:mlk_day]
    end

    it "should be accurate for Washington's Birthday" do
      test_calendar Calendar::US, @holidays[:washingtons_day]
    end

    it "should be accurate for Memorial Day" do
      test_calendar Calendar::US, @holidays[:memorial_day]
    end

    it "should be accurate for Independence Day" do
      test_calendar Calendar::US, @holidays[:independence_day]
    end

    it "should be accurate for Labor Day" do
      test_calendar Calendar::US, @holidays[:labor_day]
    end

    it "should be accurate for Columbus Day" do
      test_calendar Calendar::US, @holidays[:columbus_day]
    end

    it "should be accurate for Veterans Day" do
      test_calendar Calendar::US, @holidays[:veterans_day]
    end

    it "should be accurate for Thanksgiving Day" do
      test_calendar Calendar::US, @holidays[:thanksgiving]
    end

    it "should be accurate for Christmas Day" do
      test_calendar Calendar::US, @holidays[:christmas]
    end
  end

  describe "for Japanese holidays" do
    before :each do
      @holidays = {
        :new_years           => [[2011,  1,  1], [2012,  1,  1], [2013,  1,  1], [2014,  1,  1]],
        :seijin_no_hi        => [[2011,  1, 10], [2012,  1,  9], [2013,  1, 14], [2014,  1, 13]],
        :kenkoku_kinen_no_hi => [[2011,  2, 11], [2012,  2, 11], [2013,  2, 11], [2014,  2, 11]],
        :shunbun             => [[2011,  3, 21], [2012,  3, 20], [2013,  3, 20], [2014,  3, 21]],
        :showa_no_hi         => [[2011,  4, 29], [2012,  4, 30], [2013,  4, 29], [2014,  4, 29]],
        :golden_week         => [[2011,  5,  3], [2011,  5,  4], [2011,  5,  5],
                                 [2012,  5,  3], [2012,  5,  4], [2012,  5,  5],
                                 [2013,  5,  3], [2013,  5,  4], [2013,  5,  5], [2013,  5,  6],
                                 [2014,  5,  3], [2014,  5,  4], [2014,  5,  5], [2014,  5,  6]],
        :umi_no_hi           => [[2011,  7, 18], [2012,  7, 16], [2013,  7, 15], [2014,  7, 21]],
        :keiro_no_hi         => [[2011,  9, 19], [2012,  9, 17], [2013,  9, 16], [2014,  9, 15]],
        :shubun              => [[2011,  9, 23], [2012,  9, 22], [2013,  9, 23], [2014,  9, 23]],
        :taiiku_no_hi        => [[2011, 10, 10], [2012, 10,  8], [2013, 10, 14], [2014, 10, 13]],
        :bunka_no_hi         => [[2011, 11,  3], [2012, 11,  3], [2013, 11,  4], [2014, 11,  3]],
        :kinro_kansha_no_hi  => [[2011, 11, 23], [2012, 11, 23], [2013, 11, 23], [2014, 11, 24]],
        :tenno_tanjobi       => [[2011, 12, 23], [2012, 12, 23], [2013, 12, 23], [2014, 12, 23]],
        :bank_holidays       => [[2011,  1,  1], [2011,  1,  2], [2011,  1,  3], [2011, 12, 31],
                                 [2012,  1,  1], [2012,  1,  2], [2012,  1,  3], [2012, 12, 31],
                                 [2013,  1,  1], [2013,  1,  2], [2013,  1,  3], [2013, 12, 31],
                                 [2014,  1,  1], [2014,  1,  2], [2014,  1,  3], [2014, 12, 31]]
      }
    end

    it "should be accurate for New Year's Day" do
      test_calendar Calendar::Japan, @holidays[:new_years]
    end

    it "should be accurate for Coming of Age Day" do
      test_calendar Calendar::Japan, @holidays[:seijin_no_hi]
    end

    it "should be accurate for National Foundation Day" do
      test_calendar Calendar::Japan, @holidays[:kenkoku_kinen_no_hi]
    end

    it "should be accurate for Vernal Equinox Day" do
      test_calendar Calendar::Japan, @holidays[:shunbun]
    end

    it "should be accurate for Showa Day" do
      test_calendar Calendar::Japan, @holidays[:showa_no_hi]
    end

    it "should be accurate for Golden Week" do
      test_calendar Calendar::Japan, @holidays[:golden_week]
    end

    it "should be accurate for Marine Day" do
      test_calendar Calendar::Japan, @holidays[:umi_no_hi]
    end

    it "should be accurate for Respect-for-the-Aged Day" do
      test_calendar Calendar::Japan, @holidays[:keiro_no_hi]
    end

    it "should be accurate for Autumnal Equinox Day" do
      test_calendar Calendar::Japan, @holidays[:shubun]
    end

    it "should be accurate for Health and Sports Day" do
      test_calendar Calendar::Japan, @holidays[:taiiku_no_hi]
    end

    it "should be accurate for Culture Day" do
      test_calendar Calendar::Japan, @holidays[:bunka_no_hi]
    end

    it "should be accurate for Labour Thanksgiving Day" do
      test_calendar Calendar::Japan, @holidays[:kinro_kansha_no_hi]
    end

    it "should be accurate for the Emperor's Birthday" do
      test_calendar Calendar::Japan, @holidays[:tenno_tanjobi]
    end

    it "should be accurate for unofficial year-end bank holidays" do
      test_calendar Calendar::Japan, @holidays[:bank_holidays]
    end
  end
end
