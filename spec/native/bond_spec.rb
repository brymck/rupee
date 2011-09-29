require File.dirname(__FILE__) + "/../spec_helper"

# Discrete discounting
# new bond price = 100
#Continous discounting
# bond yield to maturity = 0.09
# new bond price = 104.282

describe Bond do
  before :each do
    @tolerance = 0.001
    @times = [1, 2, 3]
    @cflows = [10, 10, 110]
    @r = 0.09
  end

  describe "with discrete discounting" do
    before :each do
      @price = Bond.price(@times, @cflows, @r)
    end

    it "should produce an accurate price" do
      @price.should be_within(@tolerance).of 102.531
    end

    it "should produce an accurate duration" do
      Bond.duration(@times, @cflows, @r).should be_within(@tolerance).of 2.73895
    end

    it "should produce an accurate modified duration" do
      Bond.modified(@times, @cflows, @price).should be_within(@tolerance).of 2.5128
    end

    it "should produce an accurate convexity" do
      Bond.convexity(@times, @cflows, @r).should be_within(@tolerance).of 8.93248
    end

    it "should produce an accurate yield to maturity" do
      Bond.yield_to_maturity(@times, @cflows, @price).should be_within(@tolerance).of @r
    end
  end

  describe "with continuous discounting" do
    it "should produce an accurate price" do
      Bond.continuous_price(@times, @cflows, @r).should be_within(@tolerance).of 101.464
    end

    it "should produce an accurate duration" do
      Bond.continuous_duration(@times, @cflows, @r).should be_within(@tolerance).of 2.73753
    end

    it "should produce an accurate convexity" do
      Bond.continuous_convexity(@times, @cflows, @r).should be_within(@tolerance).of 7.86779
    end

    it "should produce an accurate yield to maturity" do
      @price = Bond.continuous_price(@times, @cflows, @r)
      Bond.continuous_yield_to_maturity(@times, @cflows, @price).should be_within(@tolerance).of @r
    end
  end
end
