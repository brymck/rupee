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

    def calendar=(x) # :nodoc:
      @calendar = to_constant(x, Calendar)
    end

    def currency=(x)  # :nodoc:
      @currency = to_constant(x, Currency)
    end

    private

    # Converts the supplied value to the specified constant (if it isn't
    # already one)
    def to_constant(x, constant)
      x = x.upcase

      if x.kind_of?(constant)
        x
      else
        constant.const_get(x)
      end
    end
  end
end
