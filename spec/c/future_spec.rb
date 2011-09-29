require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee::Future do
  before :each do
    @tolerance = 0.001
    @underlying = 100
    @rfr = 0.10
    @ttm = 0.5
  end

  it "should produce an accurate price" do
    Rupee::Future.price(@underlying, @rfr, @ttm).should(
      be_within(@tolerance).of 105.127
    )
  end
end
