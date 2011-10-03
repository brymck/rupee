module Rupee
  # Under construction
  #
  # A custom security that allows the user to specify cash flows, discount
  # curves, payout curves, calendars, currencies, daycounts, roll day
  # conventions, etc.
  class Custom < Security
    # The calendar used for determining holidays
    attr :calendar
    # The security's currency
    attr :currency
    # The day count convention for determining payment and accrual dates
    attr :day_count

    # Build a custom security
    #
    # Configuration options
    #
    # * <tt>:calendar</tt> - The calendar to use for determining holidays and
    #   days off (default is +:us+)
    #   * <tt>:us</tt> - The US Federal Reserve Calendar
    #   * <tt>:japan</tt> - The Japanese calendar
    # * <tt>:currency</tt> - (default is +:usd+)
    #   * <tt>:eur</tt> or <tt>:euro</tt> - The euro
    #   * <tt>:jpy</tt> or <tt>:yen</tt> - The Japanese yen
    #   * <tt>:gbp</tt> or <tt>:pound</tt> - The British pound sterling
    #   * <tt>:usd</tt> or <tt>:dollar</tt> - The US dollar
    # * <tt>:day_count</tt> - (default is +:thirty_360+)
    #   * <tt>:thirty_360</tt> - 30/360
    #   * <tt>:thirty_e_360</tt> - 30E/360
    #   * <tt>:thirty_e_360_isda</tt> - 30E/360 ISDA
    #   * <tt>:thirty_e_plus_360</tt> - 30E+/360
    #   * <tt>:act_360</tt> - Act/360
    #   * <tt>:act_365</tt> - Act/365
    #   * <tt>:act_act</tt> - Act/Act
    def initialize(opts = {})
      self.calendar  = opts[:calendar]  || :us
      self.currency  = opts[:currency]  || :usd
      self.day_count = opts[:day_count] || :thirty_360
    end

    def calendar=(calendar) # :nodoc:
      @calendar = Calendar.find(calendar)
    end

    def currency=(currency)  # :nodoc:
      @currency = Currency.find(currency)
    end

    def day_count=(day_count)  # :nodoc:
      @day_count = day_count.find(day_count)
    end
  end
end
