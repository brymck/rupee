require "rupee/import/source"
autoload :Net, "net/http"
autoload :URI, "uri"

module Rupee
  # The quote and data import functionality in Rupee
  class Import
    class << self
      # Retrieves the current price of a security
      def quote(url, *params)
        results = {}
        params = [:price] if params.empty?
        url = URI.parse(url)
        html = Net::HTTP.start(url.host, url.port) do |http|
          http.get url.request_uri
        end.body

        params.each do |p|
          results[p] = @sources[0].params[p].match(html)[1]
        end

        results
      end

      # Retrieves the current price of a security from Bloomberg
      def bloomberg(ticker, *params)
        quote BLOOMBERG_URL % ticker, *params
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
    end
  end
end
