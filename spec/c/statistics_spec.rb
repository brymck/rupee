require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee::Statistics do
  it "cumulative normal distribution should return 50% for 0" do
    Rupee::Statistics.cnd(0).round(4).should == 0.5
  end
end
