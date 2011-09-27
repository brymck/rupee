require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee::Quote do
  it "should automatically have a Bloomberg source" do
    Rupee::Quote.sources[0].name.should == :bloomberg
  end

  describe "when pulling quotes" do
    describe "without any parameters specified" do
      before :each do
        @wfc = Rupee::Quote.bloomberg("WFC")
      end

      it "should default to pulling the price" do
        @wfc.should include :price
      end

      it "should return a price" do
        @wfc[:price].to_f.should be_a_kind_of Float
      end
    end
  end
end
