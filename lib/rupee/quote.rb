require "rupee/quote/source"
autoload :Net, "net/http"
autoload :URI, "uri"

module Rupee
  # An object representing a security quote from an online source. With a
  # Rupee::Quote object, you can retrieve the most recent information on a
  # particular security using either the <tt>get</tt> method or the helper
  # methods for each parameter (e.g. <tt>price</tt>, <tt>change</tt>):
  #
  #   require "rupee/quote"
  #
  #   wfc = Rupee::Quote.new(:wfc)
  #
  #   wfc.get :price, :change, :pct_chg
  #   # => {:price=>24.96, :change=>0.17, :pct_chg =>0.686}
  #
  #   wfc.price
  #   # => 24.96
  #
  #   wfc.change
  #   # => 0.17
  class Quote
    # A ticker symbol
    attr_accessor :ticker

    # The name of the quote source
    attr_accessor :source

    # The frequency in seconds that a quote's information should be updated
    attr_accessor :frequency

    # The time at which the next pull from the online quote source will occur
    attr :next_pull

    # Creates a new Rupee::Quote object.
    #
    #   wfc = Rupee::Quote.new(:wfc)
    #
    # is equivalent to
    # 
    #   wfc = Rupee::Quote.new(:wfc, :source => :bloomberg, :frequency => 15)
    # 
    # Configuration options
    #
    # * <tt>:source</tt> - The name of the source (default is +:bloomberg+).
    #   * <tt>:bloomberg</tt> - The Bloomberg quote service
    #   * <tt>:google</tt> - The Google Finance quote service
    #   * <tt>:yahoo</tt> - The Yahoo! quote service
    # * <tt>:frequency</tt> - How often the quote will seek new values from the
    #   quote source, in seconds (default is +15+).
    def initialize(ticker, opts = {})
      opts = { :source => :bloomberg, :frequency => 15 }.merge opts
      @ticker = ticker.upcase
      @source = Quote.sources[opts[:source]]
      @frequency = opts[:frequency]
      @next_pull = Time.now
    end

    # Retrieves the current information for a security
    #
    #   Rupee::Quote.new(:wfc).get :price, :change, :pct_chg
    #   # => {:price=>24.96, :change=>0.17, :pct_chg =>0.686}
    def get(*params)
      now = Time.now
      params = [:price] if params.empty?

      if now >= @next_pull
        @next_pull = now + @frequency
        @results = {}
        url = URI.parse(@source.url % ticker)
        res = Net::HTTP.start(url.host, url.port) do |http|
          http.get url.request_uri
        end

        case res
        when Net::HTTPSuccess
          @source.params.each do |param, regex|
            begin
              @results[param] = parse(regex.match(res.body)[1])
            rescue
              @results[param] = nil
            end
          end
        else
          res.error!
        end
      end

      if params.length == 1
        @results[params[0]]
      else
        @results.keep_if { |r| params.include?(r) }
      end
    end

    # Retrieves the current information for a security
    #
    #   Rupee::Quote.new(:wfc)[:price, :change, :pct_chg]
    #   # => {:price=>24.96, :change=>0.17, :pct_chg =>0.686}
    alias :[] :get

    # call-seq: #price
    #
    # Test
    [:price, :change, :pct_chg, :date, :time, :bid, :ask, :open, :high, :low,
      :volume, :mkt_cap, :p_e].each do |method_name|
      define_method method_name do
        get method_name
      end
    end

    # The bid-ask spread
    def bid_ask
      diff bid, ask
    end

    # The daily trading range
    def range
      diff low, high
    end

    # The daily trading range
    alias :trading_range :range

    # The setter method for <tt>frequency</tt> also adjusts <tt>next_pull</tt>,
    # such that if you change <tt>frequency</tt> from <tt>15</tt> to
    # <tt>5</tt>, <tt>next_pull</tt> will move 10 seconds earlier.
    def frequency=(x)
      @next_pull += (x - @frequency)
      @frequency = x
    end

    private

    # Calculates the difference between <tt>x</tt> and <tt>y</tt>. This is
    # different from merely subtracting <tt>x</tt> from <tt>y</tt> because of
    # it forces the result to have the same number of significant digits as
    # <tt>x</tt> or <tt>y</tt>, adjusted for whichever has more.
    def diff(x, y)
      if x.nil? || y.nil?
        nil
      else
        (y - x).round precision(x, y)
      end
    end

    # Parses an object that might be a number
    #
    #   parse "15"  # => 15
    #   parse "abc" # => "abc"
    def parse(result)
      begin
        Float(result.gsub /,/, "")
      rescue
        result
      end
    end

    # Scans the values provided for the number with the greatest number of
    # decimal places, then returns that number of decimal places
    #
    #   precision 0, 1.5, 2.25, 3 # => 2
    def precision(*values)
      values.map do |value|
        temp = value.to_s.split(".")

        if temp.length > 1
          temp[1].length
        else
          0
        end
      end.max
    end
  end
end
