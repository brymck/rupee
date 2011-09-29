module Rupee
  class Quote
    # A class to hold quote sources
    class Source
      # The name of the source
      attr :name
      # The full URL for where the security information is located, where
      # <tt>%s</tt> is a query parameter
      attr :url
      # The parameters available
      attr :params

      def initialize(name, url, params = {})
        @name, @url, @params = name, url, params
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
        @sources[:bloomberg] = Source.new(:bloomberg,
          "http://www.bloomberg.com/apps/quote?ticker=%s",
          :price   => /(?:PRICE|VALUE): <span class="amount">([0-9.,NA-]{1,})/,
          :change  => /Change<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :pct_chg => /Change<\/td>\n<td class="value[^>]+>[0-9.,NA-]{1,} \(([0-9NA.,-]{1,})\%/,
          :date    => /"date">(.*?)</,
          :time    => /"time">(.*?)</,
          :bid     => /Bid<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :ask     => /Ask<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :open    => /Open<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :high    => /High<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :low     => /Low<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :volume  => /Volume<\/td>\n<td class="value[^>]+>([0-9.,NA-]{1,})/,
          :mkt_cap => /Market Cap[^<]+<\/td>\n<td class="value">([0-9.,NA-]{1,})/,
          :p_e     => /Price\/Earnings[^<]+<\/td>\n<td class="value">([0-9.,NA-]{1,})/)

        # Yahoo! Finance
        @sources[:yahoo] = Source.new(:yahoo,
          "http://finance.yahoo.com/q?s=%s",
          :price   => /(?:<\/a> |"yfnc_tabledata1"><big><b>)<span id="yfs_l[19]0_[^>]+>([0-9,.-]{1,})/,
          :change  => /><span id="yfs_c[16]0_.*?(?:\n[\s\w\-]*\n[\s">\(]*?)?([0-9.,-]{1,})/,
          :pct_chg => /yfs_p[24]0_.*?(?:\n[\s\w\-]*\n[\s">\(]*?)?([0-9.,-]{1,})%\)(?:<\/span>|<\/b><\/span><\/td>)/,
          :date    => /<span id="yfs_market_time">.*?, (.*?20[0-9]{1,2})/,
          :time    => /(?:"time"|"yfnc_tabledata1")><span id="yfs_t[51]0_[^>]+>(.*?)</,
          :bid     => /yfs_b00_[^>]+>([0-9,.-]{1,})/,
          :ask     => /yfs_a00_[^>]+>([0-9,.-]{1,})/,
          :open    => /Open:<\/th><td class="yfnc_tabledata1">([0-9,.-]{1,})/,
          :high    => /yfs_h00_[^>]+>([0-9,.-]{1,})/,
          :low     => /yfs_g00_[^>]+>([0-9,.-]{1,})/,
          :volume  => /yfs_v00_[^>]+>([0-9,.-]{1,})/,
          :mkt_cap => /yfs_j10_[^>]+>([0-9,.-]{1,}[KMBT]?)/)

        # Google Finance
        @sources[:google] = Source.new(:google,
          "http://www.google.com/ig/api?stock=%s",
          :price   => /<last data="([0-9.-]*)"/,
          :change  => /<change data="([0-9.-]*)"/,
          :pct_chg => /<perc_change data="([0-9.-]*)"/,
          :date    => /<trade_date_utc data="([0-9.-]*)"/,
          :time    => /<trade_date_utc data="([0-9.-]*)"/,
          :open    => /<open data="([0-9.-]*)"/,
          :high    => /<high data="([0-9.-]*)"/,
          :low     => /<low data="([0-9.-]*)"/,
          :volume  => /<volume data="([0-9.-]*)"/,
          :mkt_cap => /<market_cap data="([0-9.-]*)"/)

        @default_source = :bloomberg
      end
    end

    # Initialize sources
    Quote.build_sources
  end
end
