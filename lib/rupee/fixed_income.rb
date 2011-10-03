module Rupee
  # A basic fixed income security that allows the user to specify cash flows,
  # discount curves, payout curves, calendars, currencies, daycounts, roll day
  # conventions, etc.
  class FixedIncome < Security
    # The dates on which accruals start and end
    attr :accrual_dates
    # The security's business day convention
    attr :business_day
    # The calendar used for determining holidays
    attr :calendar
    # The security's currency
    attr :currency
    # The day count convention for determining payment and accrual dates
    attr :day_count
    # The date of the first coupon payment, if the security has irregular cash
    # flows
    attr :first_coupon
    # The frequency of payment periods
    attr :frequency
    # The date of the last coupon payment, if the security has irregular cash
    # flows
    attr :last_coupon
    # The maturity date of the security
    attr :maturity
    # The dates on which payments occur
    attr :payment_dates
    # The periods in years between accrual dates
    attr :periods
    # The settlement or issuance date of the security
    attr :settlement
    # The start date for accruals
    attr :start_date

    # Build a custom security
    #
    # Configuration options
    #
    # * <tt>:business_day</tt> - The security's business day convention, used
    #   to determine when the next business day is relative to the calendar in
    #   use (default is :modified_following)
    #   * <tt>:actual</tt> - The actual day, regardless of whether it's a
    #     business day
    #   * <tt>:following</tt> - The following business day
    #   * <tt>:modified_following</tt> - The following business day unless it
    #     occurs in the following month, in which case use the previous
    #     business day
    #   * <tt>:modified_previous</tt> - The previous business day unless it
    #     occurs in the previous month, in which case use the following
    #     business day
    #   * <tt>:previous</tt> - The previous business day
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
    #
    # For example, the following security types can be created (although not
    # currently priced or anything useful like that):
    #
    #   require "rupee"
    #
    #   # A typical pay-fixed bond
    #   bond = Rupee::FixedIncome.new
    #
    #   # A typical yen LIBOR security
    #   bond = Rupee::FixedIncome.new :calendar => :japan, :currency => :yen,
    #     :day_count => :act_365
    def initialize(opts = {})
      opts = {
        :business_day => :modified_following,
        :calendar     => :us,
        :currency     => :usd,
        :day_count    => :thirty_360,
        :first_coupon => nil,
        :frequency    => [6, :months],  # hands off Rails monkey-patching
        :last_coupon  => nil,
        :maturity     => Date.today.next_year,
        :settlement   => Date.today,
        :start_date   => nil
      }.merge opts

      self.business_day = opts[:business_day]
      self.calendar     = opts[:calendar]
      self.currency     = opts[:currency]
      self.day_count    = opts[:day_count]
      self.frequency    = opts[:frequency]

      @first_coupon = opts[:first_coupon]
      @last_coupon  = opts[:last_coupon]
      @maturity     = opts[:maturity]
      @settlement   = opts[:settlement]
      @start_date   = opts[:start_date]

      build_dates
    end

    def business_day=(business_day)  # :nodoc:
      @business_day = BusinessDay.find(business_day)
    end

    def calendar=(calendar)  # :nodoc:
      @calendar = Calendar.find(calendar)
    end

    def currency=(currency)  # :nodoc:
      @currency = Currency.find(currency)
    end

    def day_count=(day_count)  # :nodoc:
      @day_count = DayCount.find(day_count)
    end

    def frequency=(frequency)  # :nodoc:
      unit, amount = frequency
      @frequency = Frequency.new(unit, amount)
    end

    private

    # Builds the accrual and payment dates
    def build_dates
      from = @start_date || @settlement
      temp = from

      @accrual_dates = []
      @payment_dates = []
      @periods       = []

      unless @first_coupon_date.nil?
        from = @first_coupon_date
        @accrual_dates << from
      end

      @accrual_dates = @frequency.build(from, @maturity)

      @accrual_dates.each do |date|
        @periods << @day_count.period(temp, date)
        @payment_dates << @business_day.next_day(date, @calendar)
        temp = date
      end
    end
  end
end
