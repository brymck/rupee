# encoding: utf-8
require "rupee/mixins/find_instance"

module Rupee
  # A holder for currencies
  class Currency
    include FindInstance

    # Default currencies, autoloaded as required
    autoload :GBP,    "rupee/currency/gbp"
    autoload :POUND,  "rupee/currency/gbp"
    autoload :EUR,    "rupee/currency/eur"
    autoload :EURO,   "rupee/currency/eur"
    autoload :JPY,    "rupee/currency/jpy"
    autoload :YEN,    "rupee/currency/jpy"
    autoload :USD,    "rupee/currency/usd"
    autoload :DOLLAR, "rupee/currency/usd"

    # A simple description of the currency
    attr :description
    # The currency symbol ($, ¥, £, etc.)
    attr :symbol
    # The default number of decimal places
    attr :decimal_places
    # The delimiter for thousands places
    attr :delimiter
    # The separator for ones and decimals
    attr :separator

    # Create a new currency
    def initialize(description, opts = {})
      opts = {
        :symbol         => "$",
        :decimal_places => 2,
        :delimiter      => ",",
        :separator      => "."
      }.merge opts

      @description    = description
      @symbol         = opts[:symbol]
      @decimal_places = opts[:decimal_places]
      @delimiter      = opts[:delimiter]
      @separator      = opts[:separator]
    end

    # Returns a number using the currency's specified format
    def format(number)
      parts = number.round(@decimal_places).to_s.split(".")
      parts[0].gsub! /(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{@delimiter}"

      if @decimal_places > 0
        parts[1] = parts[1].ljust @decimal_places, "0"
      end

      "#{@symbol}#{parts.join @separator}"
    end
  end
end
