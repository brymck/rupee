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
  #   wfc = Rupee::Quote.new("WFC")
  #
  #   wfc.get :price, :change, :pct_change
  #   #=> {:price=>24.96, :change=>0.17, :pct_change =>0.686}
  #
  #   wfc.price
  #   #=> 24.96
  #
  #   wfc.change
  #   #=> 0.17
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
    #   wfc = Rupee::Quote.new("WFC")
    #
    # is equivalent to
    # 
    #   wfc = Rupee::Quote.new("WFC", :source => :bloomberg, :frequency => 15)
    # 
    # Configuration options
    #
    # * <tt>:source</tt> - The name of the source (default is +:bloomberg+).
    # * <tt>:frequency</tt> - How often the quote will seek new values from the
    #   quote source, in seconds (default is +15+).
    def initialize(ticker, opts = {})
      opts = { :source => :bloomberg, :frequency => 15 }.merge opts
      @ticker = ticker
      @source = Quote.sources[opts[:source]]
      @frequency = opts[:frequency]
      @next_pull = Time.now
    end

    # Retrieves the current price of a security
    def get(*params)
      now = Time.now
      params = [:price] if params.empty?

      if now >= @next_pull
        @next_pull = now + @frequency
        @results = {}
        url = URI.parse(@source.url % ticker)
        html = Net::HTTP.start(url.host, url.port) do |http|
          http.get url.request_uri
        end.body

        @source.params.each do |param, regex|
          begin
            @results[param] = parse(regex.match(html)[1])
          rescue
            @results[param] = nil
          end
        end
      end

      if params.length == 1
        @results[params[0]]
      else
        @results.keep_if { |r| params.include?(r) }
      end
    end

    # call-seq: #price
    #
    # Test
    [:price, :change, :pct_change, :date, :time, :bid, :ask, :open, :high,
      :low, :volume, :mkt_cap, :p_e].each do |method_name|
      define_method method_name do
        get method_name
      end
    end

    def frequency=(x) # :nodoc:
      @next_pull += (x - @frequency)
      @frequency = x
    end

    private

    # Parses an object that might be a number
    #
    #   parse "15"  #=> 15
    #   parse "abc" #=> "abc"
    def parse(result)
      begin
        Float(result)
      rescue
        result
      end
    end
  end
end
