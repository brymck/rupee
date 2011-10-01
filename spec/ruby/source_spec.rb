require File.dirname(__FILE__) + "/../spec_helper"

describe Source do
  it "should at least have a Bloomberg source" do
    Source.constants.should include :BLOOMBERG
  end
end
