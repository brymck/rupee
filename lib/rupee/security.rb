module Rupee
  # An abstract class from which all Rupee security types inherit
  class Security
    # Automatically sets all arguments passed to <tt>initialize</tt> to
    # instance variables if they exist (think Rails mass assignment).
    #
    #   require "rupee"
    #
    #   call = Rupee::Call.new(
    #     :underlying => 60,
    #     :strike     => 65,
    #     :time       =>  0.25,
    #     :rate       =>  0.08,
    #     :div_yield  =>  0.00,
    #     :volatility =>  0.3
    #   )
    #   puts call.black_scholes
    #   # => 2.1333718619275794
    #
    # You still have the option of avoiding the creation of an object (and the
    # overhead it entails) by using the class methods directly:
    #
    #   require "rupee"
    #
    #   puts Rupee::Option.black_scholes "c", 60, 65, 0.25, 0.08, 0, 0.3
    #   # => 2.1333718619275794
    def initialize(opts = {})
      opts.each do |key, value|
        writer = key.to_s.+("=").to_sym
        if respond_to?(writer)
          send writer, value
        end
      end
    end

    class << self
      # Aliases an attribute, taking into account both its getter and setter
      # methods. For example,
      #
      #   attr_accessor :price
      #   attr_alias :value, :price
      # 
      # would add both a <tt>value</tt> and a <tt>value=</tt> that are
      # equivalent to their <tt>price</tt> counterparts and would modify the
      # <tt>@price</tt> instance variable. On the other hand,
      #
      #   attr :price
      #   attr_alias :value, :price
      # 
      # would only add  <tt>value</tt> method that's equivalent to
      # <tt>price</tt>.
      def attr_alias(new_read, old_read)
        alias_method(new_read, old_read) if method_defined?(old_read)
        new_write = "#{new_read}="
        old_write = "#{old_read}="
        alias_method(new_write, old_write) if method_defined?(old_write)
      end
    end
  end
end
