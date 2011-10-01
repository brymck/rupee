require File.dirname(__FILE__) + "/../spec_helper"

describe Rupee do
  it "should produce no errors when loading all constants two levels deep" do
    Rupee.constants.each do |c|
      # Get classes and constants
      const = Rupee.const_get(c)
      const.should_not be_nil

      # Get subconstants if original constant has a constants method (or, more
      # generally, is a class)
      if const.respond_to?(:constants)
        const.constants.each do |sc|
          const.const_get(sc).should_not be_nil
        end
      end
    end
  end
end
