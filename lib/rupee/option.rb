require "rupee/security"

module Rupee
  class Option < Security
    attr_accessor :type, :underlying, :strike, :time, :rate, :div_yield, :volatility, :price
    alias :rfr :rate
    alias :rfr= :rate=
    alias :risk_free_rate :rate
    alias :risk_free_rate= :rate=
    alias :value :price
    alias :value= :price=

    def black_scholes
      @value = self.class.black_scholes @type.to_s, @underlying, @strike, @time, @rate, @div_yield, @volatility
    end
  end

  class Call < Option
    def initialize(opts = {})
      @type = "call"
      super
    end
  end

  class Put < Option
    def initialize(opts = {})
      @type = :put
      super
    end
  end
end
