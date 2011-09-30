require File.dirname(__FILE__) + "/../spec_helper"

describe Calendar do
  describe "for Federal Reserve holidays" do
    it "should be accurate for New Year's Day" do
      Calendar::US.day_off?(Time.new(2011, 1, 1)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 1, 2)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 1, 1)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 1, 1)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 1, 1)).should_not be false
    end

    it "should be accurate for Martin Luther King's Birthday" do
      Calendar::US.day_off?(Time.new(2011, 1, 17)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 1, 16)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 1, 21)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 1, 20)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 1, 19)).should_not be false
    end

    it "should be accurate for Washington's Birthday" do
      Calendar::US.day_off?(Time.new(2011, 2, 21)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 2, 20)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 2, 18)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 2, 17)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 2, 16)).should_not be false
    end

    it "should be accurate for Memorial Day" do
      Calendar::US.day_off?(Time.new(2011, 5, 30)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 5, 28)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 5, 27)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 5, 26)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 5, 25)).should_not be false
    end

    it "should be accurate for Independence Day" do
      Calendar::US.day_off?(Time.new(2011, 7, 4)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 7, 4)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 7, 4)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 7, 4)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 7, 4)).should_not be false
    end

    it "should be accurate for Labor Day" do
      Calendar::US.day_off?(Time.new(2011, 9, 5)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 9, 3)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 9, 2)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 9, 1)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 9, 7)).should_not be false
    end

    it "should be accurate for Columbus Day" do
      Calendar::US.day_off?(Time.new(2011, 10, 10)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 10, 8)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 10, 14)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 10, 13)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 10, 12)).should_not be false
    end

    it "should be accurate for Veterans Day" do
      Calendar::US.day_off?(Time.new(2011, 11, 11)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 11, 12)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 11, 11)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 11, 11)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 11, 11)).should_not be false
    end

    it "should be accurate for Thanksgiving Day" do
      Calendar::US.day_off?(Time.new(2011, 11, 24)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 11, 22)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 11, 28)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 11, 27)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 11, 26)).should_not be false
    end

    it "should be accurate for Christmas Day" do
      Calendar::US.day_off?(Time.new(2011, 12, 26)).should_not be false
      Calendar::US.day_off?(Time.new(2012, 12, 25)).should_not be false
      Calendar::US.day_off?(Time.new(2013, 12, 25)).should_not be false
      Calendar::US.day_off?(Time.new(2014, 12, 25)).should_not be false
      Calendar::US.day_off?(Time.new(2015, 12, 25)).should_not be false
    end
  end
end
