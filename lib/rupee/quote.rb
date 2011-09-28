require "rupee/quote/source"
autoload :Net, "net/http"
autoload :URI, "uri"

module Rupee
  # The quote and data import functionality in Rupee
  class Quote
    # A ticker symbol
    attr_accessor :ticker

    # The name of the quote source
    attr_accessor :source

    # The cached HTML
    attr :html

    attr_accessor :frequency

    attr :next_pull

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
        url = BLOOMBERG_URL % ticker
        @results = {}
        url = URI.parse(url)
        @html = Net::HTTP.start(url.host, url.port) do |http|
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

    [:price, :change, :pct_change, :date, :time, :bid, :ask, :open, :high,
      :low, :volume, :mkt_cap, :p_e].each do |method_name|
      define_method method_name do
        get method_name
      end
    end

    private

    # The URL for Bloomberg's quotes service
    BLOOMBERG_URL = "http://www.bloomberg.com/apps/quote?ticker=%s"

    # Returns an intepretation of an abbreviated source name
    def shorten_source(source)
      case source.downcase.to_sym
      when :"", :bloomberg, :bberg, :bb, :b
        :bloomberg
      when :google, :goog, :g
        :google
      when :yahoo!, :yahoo, :yhoo, :y!, :y
        :yahoo
      end
    end

    def parse(result)
      begin
        Float(result)
      rescue
        result
      end
    end
  end
end
