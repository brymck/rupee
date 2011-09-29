require File.dirname(__FILE__) + "/../spec_helper"

# Discrete discounting
# new bond price = 100
#Continous discounting
# bond yield to maturity = 0.09
# new bond price = 104.282

describe Rupee::Bond do
  before :each do
    @tolerance = 0.001
    @times = [1, 2, 3]
    @cflows = [10, 10, 110]
    @r = 0.09
  end

  describe "with discrete discounting" do
    before :each do
      @price = Rupee::Bond.price(@times, @cflows, @r)
    end

    it "should produce an accurate price" do
      @price.should be_within(@tolerance).of 102.531
    end

    it "should produce an accurate duration" do
      Rupee::Bond.duration(@times, @cflows, @r).should be_within(@tolerance).of 2.73895
    end

    it "should produce an accurate modified duration" do
      Rupee::Bond.modified(@times, @cflows, @price).should be_within(@tolerance).of 2.5128
    end

    it "should produce an accurate convexity" do
      Rupee::Bond.convexity(@times, @cflows, @r).should be_within(@tolerance).of 8.93248
    end

    it "should produce an accurate yield to maturity" do
      Rupee::Bond.yield_to_maturity(@times, @cflows, @price).should be_within(@tolerance).of @r
    end
  end

  describe "with continuous discounting" do
    it "should produce an accurate price" do
      Rupee::Bond.continuous_price(@times, @cflows, @r).should be_within(@tolerance).of 101.464
    end

    it "should produce an accurate duration" do
      Rupee::Bond.continuous_duration(@times, @cflows, @r).should be_within(@tolerance).of 2.73753
    end

    it "should produce an accurate convexity" do
      Rupee::Bond.continuous_convexity(@times, @cflows, @r).should be_within(@tolerance).of 7.86779
    end

    it "should produce an accurate yield to maturity" do
      @price = Rupee::Bond.continuous_price(@times, @cflows, @r)
      Rupee::Bond.continuous_yield_to_maturity(@times, @cflows, @price).should be_within(@tolerance).of @r
    end
  end
end
