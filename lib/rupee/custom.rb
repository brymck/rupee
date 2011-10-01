require "rupee/util"

module Rupee
  # Under construction
  #
  # A custom security that allows the user to specify cash flows, discount
  # curves, payout curves, calendars, currencies, daycounts, roll day
  # conventions, etc.
  class Custom < Security
    include ClassFinder

    # The Calendar object
    attr :calendar
    # The security's Currency
    attr :currency

    # Build a custom security
    def initialize(opts = {})
      opts = {
        :calendar => :us,
        :currency => :usd
      }.merge opts

      self.calendar = opts[:calendar]
      self.currency = opts[:currency]
    end

    def calendar=(x) # :nodoc:
      @calendar = to_instance(x, Calendar)
    end

    def currency=(x)  # :nodoc:
      @currency = to_instance(x, Currency)
    end
  end
end
