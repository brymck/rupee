autoload :Net, "net/http"
autoload :URI, "uri"

module Rupee
  # The quote and data import functionality in Rupee
  class Import
    class << self
      # Retrieves the current price of a security
      def quote(url, *options)
        url = URI.parse(url)
        res = Net::HTTP.start(url.host, url.port) do |http|
          http.get url.request_uri
        end
        puts res.body
      end

      # Retrieves the current price of a security from Bloomberg
      def bloomberg(ticker, *options)
        quote BLOOMBERG_URL % ticker, options
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
