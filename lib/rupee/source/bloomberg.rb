module Rupee
  class Source
    # Bloomberg
    BLOOMBERG = Source.new(:bloomberg,
      "http://www.bloomberg.com/quote/%s",
      :price   => /" price">\s*\n\s*([0-9,.-]+)/,
      :change  => /trending_[^>]+>([0-9NA.,-]+)/,
      :pct_chg => /trending_[^>]+>[0-9NA.,-]+\s+<span>([0-9,.NA-]+)/,
      :date    => /"date">(.*?)</,
      :time    => /"time">(.*?)</,
      :bid     => /Bid<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/,
      :ask     => /Ask<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/,
      :open    => /Open<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/,
      :high    => /High<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/,
      :low     => /Low<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/,
      :volume  => /Volume<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/,
      :mkt_cap => /Market Cap[^<]+<\/td>\n<td class[^>]+">([0-9.,NA-]{1,})/,
      :p_e     => /Price\/Earnings[^<]+<\/td>\n<td class[^>]+>([0-9.,NA-]{1,})/)
  end
end
