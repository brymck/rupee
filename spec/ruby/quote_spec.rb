describe Quote do
  # Attempts to run the block and submits a pending message if a socket error
  # occurs, the most common cause of which is that the user isn't connected to
  # the internet
  def run_if_connected(&block)
    begin
      block.call
    rescue SocketError
      pending "Socket error: you're probably not connected to the internet"
    end
  end

  describe "without any parameters specified" do
    before :each do
      @wfc = Quote.new(:wfc)
    end

    it "should default to pulling the price" do
      run_if_connected do
        @wfc.get.should == @wfc.price
      end
    end

    it "should return a price" do
      run_if_connected do
        @wfc.price.should be_a_kind_of Float
      end
    end

    [:change, :pct_chg].each do |param|
      it "should have a #{param}" do
        run_if_connected do
          @wfc.send(param).should be_a_kind_of Float
        end
      end
    end

    it "should reflect changes to frequency in next pull time" do
      freq_change = 5
      orig_freq = @wfc.frequency
      orig_pull = @wfc.next_pull
      @wfc.frequency -= freq_change
      @wfc.next_pull.should == orig_pull - freq_change
    end

    it "should be able to detect negative and positive changes" do
      run_if_connected do
        eurusd = Quote.new("EURUSD:IND").change
        usdeur = Quote.new("USDEUR:IND").change
        eurusd.should be_within(0.01).of -usdeur
      end
    end
  end

  describe "requesting security types with special treatment in Bloomberg" do
    it "should grab a change for indices" do
      run_if_connected do
        Quote.new("SPX:IND").change.should_not be_nil
      end
    end

    it "should grab a change for ETFs" do
      run_if_connected do
        Quote.new("DBA").change.should_not be_nil
      end
    end
  end

  describe "specifying Google Finance as the quote service" do
    before :each do
      @goog = Quote.new("GOOG", :source => :google)
    end

    it "should have around the same price as Bloomberg" do
      run_if_connected do
        bb_price = Quote.new("GOOG").price
        bb_price.should be_a_kind_of Float
        @goog.price.should be_within(10).of bb_price
      end
    end

    [:change, :pct_chg].each do |param|
      it "should have around the same #{param} as Bloomberg" do
        run_if_connected do
          bb_result = Quote.new("GOOG").send(param)
          bb_result.should be_a_kind_of Float
          @goog.send(param).should be_within(10).of bb_result
        end
      end
    end
  end

  describe "specifying Yahoo! Finance as the quote service" do
    before :each do
      @yahoo = Quote.new("YHOO", :source => :yahoo)
    end

    it "should have around the same price as Bloomberg" do
      run_if_connected do
        bb_price = Quote.new("YHOO").price
        bb_price.should be_a_kind_of Float
        @yahoo.price.should be_within(1).of bb_price
      end
    end

    [:change, :pct_chg].each do |param|
      it "should have around the same #{param} as Bloomberg" do
        run_if_connected do
          bb_result = Quote.new("YHOO").send(param)
          bb_result.should be_a_kind_of Float
          @yahoo.send(param).should be_within(10).of bb_result
        end
      end
    end

    it "should be able to detect negative and positive changes" do
      run_if_connected do
        eurusd = Quote.new("EURUSD=X", :source => :yahoo).change
        usdeur = Quote.new("USDEUR=X", :source => :yahoo).change
        eurusd.should be_within(0.01).of -usdeur
      end
    end
  end
end
