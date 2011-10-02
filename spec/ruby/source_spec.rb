require File.dirname(__FILE__) + "/../spec_helper"

describe Source do
  it "should have a Bloomberg source" do
    Source.find(:bloomberg).should_not be_nil
  end

  it "should have a Google source" do
    Source.find(:google).should_not be_nil
  end

  it "should have a Yahoo! source" do
    Source.find(:yahoo).should_not be_nil
  end
end
