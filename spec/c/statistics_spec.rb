require File.dirname(__FILE__) + "/../spec_helper"

describe "Cumulative normal distribution" do
  it "should return a probability of 50% for 0" do
    Rupee::Distribution.cnd(0).round(4).should == 0.5
  end
end
