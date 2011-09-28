require File.dirname(__FILE__) + "/../spec_helper"

# Discrete discounting
# bonds price    = 102.531
# bond yield to maturity = 0.09
# bond duration  = 2.73895
# bond duration modified = 2.5128
# bond convexity =8.93248
# new bond price = 100
#Continous discounting
# bonds price    = 101.464
# bond yield to maturity = 0.09
# bond duration  = 2.73753
# bond convexity =7.86779
# new bond price = 104.282

TOLERANCE = 0.001

describe Rupee::Bond do
  before :each do
    @times = [1, 2, 3]
    @cflows = [10, 10, 110]
    @r = 0.09
  end

  describe "with continuous discounting" do
    it "should produce an accurate price" do
      Rupee::Bond.price(@times, @cflows, @r).should be_within(TOLERANCE).of 101.464
    end

    it "should produce an accurate duration" do
      Rupee::Bond.duration(@times, @cflows, @r).should be_within(TOLERANCE).of 2.73753
    end

    it "should produce an accurate convexity" do
      Rupee::Bond.convexity(@times, @cflows, @r).should be_within(TOLERANCE).of 7.86779
    end
  end
end
