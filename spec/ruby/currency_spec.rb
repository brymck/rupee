# encoding: utf-8
require File.dirname(__FILE__) + "/../spec_helper"

describe Currency do
  it "should at least have the dollar, euro, pound and yen" do
    Currency::USD.should_not be_nil
    Currency::EUR.should_not be_nil
    Currency::GBP.should_not be_nil
    Currency::JPY.should_not be_nil
  end

  it "should have more readable aliases for the dollar, euro, pound and yen" do
    Currency::DOLLAR.should be Currency::USD
    Currency::EURO.should be Currency::EUR
    Currency::POUND.should be Currency::GBP
    Currency::YEN.should be Currency::JPY
  end

  it "should apply the correct format for the dollar, euro, pound and yen" do
    Currency::USD.format(1_234_567.89).should == "$1,234,567.89"
    Currency::EUR.format(1_234_567.89).should == "€1,234,567.89"
    Currency::GBP.format(1_234_567.89).should == "£1,234,567.89"
    Currency::JPY.format(1_234_567.89).should == "¥1,234,568"
  end
end
