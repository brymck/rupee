require "rupee/security"

module Rupee
  class Option < Security
    # The type of the option. Accepts <tt>"call"</tt> and <tt>"put"</tt>.
    attr_accessor :type
    # The price of the underlying security
    attr_accessor :underlying
    # The strike price of the underlying security
    attr_accessor :strike
    # The remaining time to maturity
    attr_accessor :time
    # The risk-free rate
    attr_accessor :rate
    # The dividend yield
    attr_accessor :div_yield
    # The annualized price volatility
    attr_accessor :volatility
    # The price of the option
    attr_accessor :price

    attr_alias :rfr, :rate
    attr_alias :risk_free_rate, :rate
    attr_alias :value, :price

    def black_scholes
      @value = self.class.black_scholes @type.to_s, @underlying, @strike,
        @time, @rate, @div_yield, @volatility
    end
    
    [:charm, :color, :delta, :dual_delta, :dual_gamma, :dvega_dtime, :gamma,
      :rho, :speed, :theta, :vanna, :vega, :vomma, :zomma].each do |method_name|
      define_method method_name do
        self.class.send method_name, @type, @underlying, @strike, @time,
          @rate, @div_yield, @volatility
      end
    end
  end

  # The same thing as Rupee::Option, but with the <tt>:type</tt> flag set to
  # <tt>"call"</tt>
  class Call < Option
    def initialize(opts = {}) # :nodoc:
      @type = "call"
      super
    end
  end

  # The same thing as Rupee::Option, but with the <tt>:type</tt> flag set to
  # <tt>"put"</tt>
  class Put < Option
    def initialize(opts = {}) # :nodoc:
      @type = :put
      super
    end
  end
end
