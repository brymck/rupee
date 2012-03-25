describe FixedIncome do
  it "should be able to instantiate a basic fixed income product" do
    lambda { FixedIncome.new }.should_not raise_error
  end
end
