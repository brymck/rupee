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
      :bid     => /Bid:<\/th>\n\s*<td[^>]*>([0-9.,NA-]{1,})/,
      :ask     => /Ask:<\/th>\n\s*<td[^>]*>([0-9.,NA-]{1,})/,
      :open    => /Open:<\/th>\n\s*<td[^>]*>([0-9.,NA-]{1,})/,
      :high    => /(?:Day(?:'s)? Range:<\/th>\n\s*<td[^>]*>[0-9.,NA-]+ - |High - Low:<\/th>\n\s*<td[^>]*>)([0-9.,NA-]+)/,
      :low     => /(?:Day(?:'s)? Range:<\/th>\n\s*<td[^>]*>|High - Low:<\/th>\n\s*<td[^>]*>[0-9.,NA-]+ - )([0-9.,NA-]+)/,
      :volume  => /Volume:<\/th>\n\s*<td class[^>]+>([0-9.,NA-]{1,})/,
      :mkt_cap => /Market Cap[^<]+<\/th>\n\s*<td[^>]*">([0-9.,NA-]{1,})/,
      :p_e     => /Current P\/E[^<]+<\/th>\n\s*<td[^>]*>([0-9.,NA-]{1,})/)
  end
end
