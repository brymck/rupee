require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee::Quote do
  it "should automatically have a Bloomberg source" do
    Rupee::Quote.sources.should include :bloomberg
  end

  describe "when pulling quotes" do
    describe "without any parameters specified" do
      before :each do
        @wfc = Rupee::Quote.new("WFC")
      end

      it "should default to pulling the price" do
        @wfc.get.should == @wfc.price
      end

      it "should return a price" do
        @wfc.price.should be_a_kind_of Float
      end
    end
  end
end
