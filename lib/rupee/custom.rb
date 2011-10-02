module Rupee
  # Under construction
  #
  # A custom security that allows the user to specify cash flows, discount
  # curves, payout curves, calendars, currencies, daycounts, roll day
  # conventions, etc.
  class Custom < Security
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

    def calendar=(calendar) # :nodoc:
      @calendar = Calendar.find(calendar)
    end

    def currency=(currency)  # :nodoc:
      @currency = Currency.find(currency)
    end
  end
end
