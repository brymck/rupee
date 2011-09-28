module Rupee
  class Quote
    # A class to hold quote sources
    class Source
      # The name of the source
      attr :name

      # The parameters available
      attr :params

      def initialize(name, aliases = [], params = {})
        @name = name
        @aliases = aliases
        @params = params
      end
    end

    class << self
      # A holder for the sources available
      attr :sources

      # The default source to use when making generic requests
      attr :default_source

      # Build the default sources that come with Rupee
      def build_sources
        @sources ||= {}

        # Bloomberg
        @sources[:bloomberg] = Source.new(:bloomberg, [:bberg, :bb, :b], 
          :price => /(?:PRICE|VALUE): <span class="amount">([0-9.,NA-]{1,})/,
          :change => /Change<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :pct_change => /Change<\/td>\n<td class="value[^>]+>[0-9.,NA-]{1,} \(([0-9NA.,-]{1,})\%/,
          :date => /"date">(.*?)</,
          :time => /"time">(.*?)</,
          :bid => /Bid<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :ask => /Ask<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :open => /Open<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :high => /High<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :low => /Low<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :volume => /Volume<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :mkt_cap => /Market Cap[^<]+<\/td>\n<td class="value">([0-9.,NA-]{1,})/,
          :p_e     => /Price\/Earnings[^<]+<\/td>\n<td class="value">([0-9.,NA-]{1,})/)
        @sources[:yahoo] = Source.new(:yahoo)
        @sources[:google] = Source.new(:google)
        @default_source = :bloomberg
      end
    end

    # Initialize sources
    Quote.build_sources
  end
end
