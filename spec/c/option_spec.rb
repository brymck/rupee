require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee::Option do
  describe "European option valuation" do
    describe "using the Black-76 model" do
      describe "on a call option of price $60, strike $65, time to expiry 0.25, risk-free rate 8%, and volatility 30%" do
        it "should return $1.7202 for a call" do
          Rupee::Option.black76("c", 60, 65, 0.25, 0.08, 0.3).round(4).should == 1.7202
        end

        it "should return $6.6212 for a put" do
          Rupee::Option.black76("p", 60, 65, 0.25, 0.08, 0.3).round(4).should == 6.6212
        end
      end
    end

    describe "using the generalized Black-Scholes model" do
      describe "on a call option of price $60, strike $65, time to expiry 0.25, risk-free rate 8%, and volatility 30%" do
        it "should return $1.7202 for a call" do
          Rupee::Option.generalized_black_scholes("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 1.7202
          Rupee::Option.gbs("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 1.7202
        end

        it "should return $6.6212 for a put" do
          Rupee::Option.generalized_black_scholes("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 6.6212
          Rupee::Option.gbs("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 6.6212
        end
      end
    end

    describe "using the Black-Scholes model" do
      describe "on a call option of price $60, strike $65, time to expiry 0.25, risk-free rate 8%, and volatility 30%" do
        it "should return $1.7202 for a call" do
          Rupee::Option.black_scholes("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 2.1334
          Rupee::Option.bs("c", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 2.1334
        end

        it "should return $6.6212 for a put" do
          Rupee::Option.black_scholes("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 5.8463
          Rupee::Option.bs("p", 60, 65, 0.25, 0.08, 0, 0.3).round(4).should == 5.8463
        end
      end
    end
  end
end
