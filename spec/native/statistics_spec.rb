describe Statistics do
  before :each do
    @tolerance = 0.0001
    @values = [0, 1, 2, 3, 4]
    @more_values = [0, 1, 2, 4, 8]
  end

  it "should return an accurate cumulative normal distribution" do
    @result = Statistics.cnd(0)
    @result.should be_within(@tolerance).of 0.5
    Statistics.cumulative_normal_distribution(0).should == @result
  end

  it "should return an accurate sum" do
    Statistics.sum(@values).should == 10
  end

  it "should return an accurate mean" do
    Statistics.mean(@values).should == 2
    Statistics.average(@values).should == 2
    Statistics.avg(@values).should == 2
  end

  it "should return an accurate standard deviation" do
    @result = Statistics.standard_deviation(@values)
    @result.should be_within(@tolerance).of 1.4142
    Statistics.std(@values).should == @result
    Statistics.stdev(@values).should == @result
  end

  it "should return an accurate variance" do
    Statistics.variance(@values).should == 2
    Statistics.var(@values).should == 2
  end

  it "should return an accurate covariance" do
    Statistics.covariance(@values, @more_values).should == 3.8
    Statistics.cov(@values, @more_values).should == 3.8
    Statistics.covar(@values, @more_values).should == 3.8
  end

  it "should return an accurate correlation" do
    @result = Statistics.correlation(@values, @more_values)
    @result.should be_within(@tolerance).of 0.95
    Statistics.corr(@values, @more_values).should == @result
    Statistics.correl(@values, @more_values).should == @result
  end
end
