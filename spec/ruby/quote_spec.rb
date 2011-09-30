require File.dirname(__FILE__) + "/../spec_helper"

describe Quote do
  it "should automatically have a Bloomberg source" do
    Quote.sources.should include :bloomberg
  end

  describe "when pulling quotes" do
    describe "without any parameters specified" do
      before :each do
        @wfc = Quote.new(:wfc)
      end

      it "should default to pulling the price" do
        @wfc.get.should == @wfc.price
      end

      it "should return a price" do
        @wfc.price.should be_a_kind_of Float
      end

      it "should reflect changes to frequency in next pull time" do
        freq_change = 5
        orig_freq = @wfc.frequency
        orig_pull = @wfc.next_pull
        @wfc.frequency -= freq_change
        @wfc.next_pull.should == orig_pull - freq_change
      end
    end

    describe "specifying Google Finance as the quote service" do
      before :each do
        @goog = Quote.new("GOOG", :source => :google)
      end

      it "should have around the same price as Bloomberg" do
        bb_price = Quote.new("GOOG").price
        bb_price.should be_a_kind_of Float
        @goog.price.should be_within(0.05).of bb_price
      end
    end

    describe "specifying Yahoo! Finance as the quote service" do
      before :each do
        @yahoo = Quote.new("YHOO", :source => :yahoo)
      end

      it "should have around the same price as Bloomberg" do
        bb_price = Quote.new("YHOO").price
        bb_price.should be_a_kind_of Float
        @yahoo.price.should be_within(0.05).of bb_price
      end
    end
  end
end
