require File.dirname(__FILE__) + "/../spec_helper"

describe "European option valuation" do
  describe "using the Black-76 model" do
    describe "on a call option of price $60, strike $65, time to expiry 0.25, risk-free rate 8%, and volatility 30%" do
      it "should return $1.7202 for a call" do
        Rupee::Options.black76("c", 60, 65, 0.25, 0.08, 0.3).round(4).should == 1.7202
      end

      it "should return $6.6212 for a put" do
        Rupee::Options.black76("p", 60, 65, 0.25, 0.08, 0.3).round(4).should == 6.6212
      end
    end
  end

  describe "using the generalized Black-Scholes model" do
    describe "on a call option of price $60, strike $65, time to expiry 0.25, risk-free rate 8%, and volatility 30%" do
      it "should return $1.7202 for a call" do
        Rupee::Options.generalized_black_scholes("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 1.7202
        Rupee::Options.gbs("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 1.7202
      end

      it "should return $6.6212 for a put" do
        Rupee::Options.generalized_black_scholes("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 6.6212
        Rupee::Options.gbs("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 6.6212
      end
    end
  end

  describe "using the Black-Scholes model" do
    describe "on a call option of price $60, strike $65, time to expiry 0.25, risk-free rate 8%, and volatility 30%" do
      it "should return $1.7202 for a call" do
        Rupee::Options.black_scholes("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 2.1334
        Rupee::Options.bs("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 2.1334
      end

      it "should return $6.6212 for a put" do
        Rupee::Options.black_scholes("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 5.8463
        Rupee::Options.bs("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 5.8463
      end
    end
  end
end
