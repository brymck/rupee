describe BusinessDay do
  before :each do
    @new_years = Date.new(2012, 1, 1)
    @new_years_eve = Date.new(2011, 12, 31)
    @workday = Date.new(2011, 11, 23)
    @calendar = Calendar::US
  end

  describe "for the actual convention" do
    before :each do
      @business_day = BusinessDay.find(:actual)
      @month_begin_rolled = Date.new(2012, 1, 1)
      @month_end_rolled = Date.new(2011, 12, 31)
      @workday_rolled = Date.new(2011, 11, 23)
    end

    it "should be correct for the beginning of the month" do
      @business_day.next_day(@new_years, @calendar).should == @month_begin_rolled
    end

    it "should be correct for the end of the month" do
      @business_day.next_day(@new_years_eve, @calendar).should == @month_end_rolled
    end

    it "should be correct for an actual workday" do
      @business_day.next_day(@workday, @calendar).should == @workday_rolled
    end
  end

  describe "for the following convention" do
    before :each do
      @business_day = BusinessDay.find(:following)
      @month_begin_rolled = Date.new(2012, 1, 3)
      @month_end_rolled = Date.new(2012, 1, 3)
      @workday_rolled = Date.new(2011, 11, 23)
    end

    it "should be correct for the beginning of the month" do
      @business_day.next_day(@new_years, @calendar).should == @month_begin_rolled
    end

    it "should be correct for the end of the month" do
      @business_day.next_day(@new_years_eve, @calendar).should == @month_end_rolled
    end

    it "should be correct for an actual workday" do
      @business_day.next_day(@workday, @calendar).should == @workday_rolled
    end
  end

  describe "for the modified following convention" do
    before :each do
      @business_day = BusinessDay.find(:modified_following)
      @month_begin_rolled = Date.new(2012, 1, 3)
      @month_end_rolled = Date.new(2011, 12, 30)
      @workday_rolled = Date.new(2011, 11, 23)
    end

    it "should be correct for the beginning of the month" do
      @business_day.next_day(@new_years, @calendar).should == @month_begin_rolled
    end

    it "should be correct for the end of the month" do
      @business_day.next_day(@new_years_eve, @calendar).should == @month_end_rolled
    end

    it "should be correct for an actual workday" do
      @business_day.next_day(@workday, @calendar).should == @workday_rolled
    end
  end

  describe "for the modified previous convention" do
    before :each do
      @business_day = BusinessDay.find(:modified_previous)
      @month_begin_rolled = Date.new(2012, 1, 3)
      @month_end_rolled = Date.new(2011, 12, 30)
      @workday_rolled = Date.new(2011, 11, 23)
    end

    it "should be correct for the beginning of the month" do
      @business_day.next_day(@new_years, @calendar).should == @month_begin_rolled
    end

    it "should be correct for the end of the month" do
      @business_day.next_day(@new_years_eve, @calendar).should == @month_end_rolled
    end

    it "should be correct for an actual workday" do
      @business_day.next_day(@workday, @calendar).should == @workday_rolled
    end
  end

  describe "for the previous convention" do
    before :each do
      @business_day = BusinessDay.find(:previous)
      @month_begin_rolled = Date.new(2011, 12, 30)
      @month_end_rolled = Date.new(2011, 12, 30)
      @workday_rolled = Date.new(2011, 11, 23)
    end

    it "should be correct for the beginning of the month" do
      @business_day.next_day(@new_years, @calendar).should == @month_begin_rolled
    end

    it "should be correct for the end of the month" do
      @business_day.next_day(@new_years_eve, @calendar).should == @month_end_rolled
    end

    it "should be correct for an actual workday" do
      @business_day.next_day(@workday, @calendar).should == @workday_rolled
    end
  end
end
