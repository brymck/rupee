require File.dirname(__FILE__) + "/../spec_helper"

describe Option do
  describe "European option valuation" do
    before :each do
      @tolerance = 0.0001
      @underlying = 60
      @strike     = 65
      @time       = 0.25
      @rate       = 0.08
      @div_yield  = 0.0
      @volatility = 0.3

      @call = Call.new(
        :underlying => @underlying,
        :strike     => @strike,
        :time       => @time,
        :rate       => @rate,
        :div_yield  => @div_yield,
        :volatility => @volatility
      )

      @put = Put.new(
        :underlying => @underlying,
        :strike     => @strike,
        :time       => @time,
        :rate       => @rate,
        :div_yield  => @div_yield,
        :volatility => @volatility
      )
    end

    describe "using the Black-76 model" do
      it "should return an accurate valuation for a call" do
        Option.black76("c", @underlying, @strike, @time, @rate, @volatility).should be_within(@tolerance).of 1.7202
      end

      it "should return an accurate valuation for a put" do
        Option.black76("p", @underlying, @strike, @time, @rate, @volatility).should be_within(@tolerance).of 6.6212
      end
    end

    describe "using the generalized Black-Scholes model" do
      it "should return an accurate valuation for a call" do
        Option.generalized_black_scholes("c", @underlying, @strike, @time, @rate, @div_yield, @volatility).should be_within(@tolerance).of 1.7202
        Option.gbs("c", @underlying, @strike, @time, @rate, @div_yield, @volatility).should be_within(@tolerance).of 1.7202
      end

      it "should return an accurate valuation for a put" do
        Option.generalized_black_scholes("p", @underlying, @strike, @time, @rate, @div_yield, @volatility).should be_within(@tolerance).of 6.6212
        Option.gbs("p", @underlying, @strike, @time, @rate, @div_yield, @volatility).should be_within(@tolerance).of 6.6212
      end
    end

    describe "using the Black-Scholes model" do
      describe "on a call option" do
        it "should return an accurate valuation" do
          value = @call.black_scholes
          value.should be_within(@tolerance).of 2.1334
          Option.black_scholes("c", @underlying, @strike, @time, @rate, @div_yield, @volatility).should == value
          Option.bs("c", @underlying, @strike, @time, @rate, @div_yield, @volatility).should == value
        end

        it "should return an accurate charm" do
          value = @call.charm
          value.should be_a_kind_of Float
        end

        it "should return an accurate color" do
          value = @call.color
          value.should be_a_kind_of Float
        end

        it "should return an accurate delta" do
          value = @call.delta
          value.should be_a_kind_of Float
        end

        it "should return an accurate dual_delta" do
          value = @call.dual_delta
          value.should be_a_kind_of Float
        end

        it "should return an accurate dual_gamma" do
          value = @call.dual_gamma
          value.should be_a_kind_of Float
        end

        it "should return an accurate dvega_dtime" do
          value = @call.dvega_dtime
          value.should be_a_kind_of Float
        end

        it "should return an accurate gamma" do
          value = @call.gamma
          value.should be_a_kind_of Float
        end

        it "should return an accurate rho" do
          value = @call.rho
          value.should be_a_kind_of Float
        end

        it "should return an accurate speed" do
          value = @call.speed
          value.should be_a_kind_of Float
        end

        it "should return an accurate theta" do
          value = @call.theta
          value.should be_a_kind_of Float
        end

        it "should return an accurate vanna" do
          value = @call.vanna
          value.should be_a_kind_of Float
        end

        it "should return an accurate vega" do
          value = @call.vega
          value.should be_a_kind_of Float
        end

        it "should return an accurate vomma" do
          value = @call.vomma
          value.should be_a_kind_of Float
        end

        it "should return an accurate zomma" do
          value = @call.zomma
          value.should be_a_kind_of Float
        end
      end

      describe "on a put option" do
        it "should return an accurate valuation" do
          value = @put.black_scholes
          value.should be_within(@tolerance).of 5.8463
          Option.black_scholes("p", @underlying, @strike, @time, @rate, @div_yield, @volatility).should == value
          Option.bs("p", @underlying, @strike, @time, @rate, @div_yield, @volatility).should == value
        end
      end
    end
  end
end
