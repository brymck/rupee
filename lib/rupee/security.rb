module Rupee
  # An abstract class from which all Rupee security types inherit
  class Security
    # Automatically sets all arguments passed to <tt>initialize</tt> to
    # instance variables if they exist (think Rails mass assignment).
    #
    #     require "rupee"
    #
    #     call = Rupee::Call.new(
    #       :underlying => 60,
    #       :strike     => 65,
    #       :time       =>  0.25,
    #       :rate       =>  0.08,
    #       :div_yield  =>  0.00,
    #       :volatility =>  0.3
    #     )
    #     puts call.black_scholes
    #     #=> 2.1333718619275794
    #
    # You still have the option of avoiding the creation of an object (and the
    # overhead it entails) by using the class methods directly:
    #
    #     require "rupee"
    #
    #     puts Rupee::Option.black_scholes "c", 60, 65, 0.25, 0.08, 0, 0.3
    #     #=> 2.1333718619275794
    def initialize(opts = {})
      opts.each do |key, value|
        writer = key.to_s.+("=").to_sym
        if respond_to?(writer)
          send writer, value
        end
      end
    end
  end
end
