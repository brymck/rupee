module Rupee
  class Source
    # Bloomberg
    BLOOMBERG = Source.new(:bloomberg,
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
  end
end
