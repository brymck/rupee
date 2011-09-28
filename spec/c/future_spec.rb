require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee::Future do
  before :each do
    @underlying = 100
    @rfr = 0.10
    @ttm = 0.5
  end

  it "should produce an accurate price" do
    Rupee::Future.price(@underlying, @rfr, @ttm).should be_within(TOLERANCE).of 105.127
  end
end
