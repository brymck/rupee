module Rupee
  class Source
    YAHOO = Source.new(:yahoo,
      "http://finance.yahoo.com/q?s=%s",
      :price   => /yfs_l84_[^>]+>([0-9,.-]+)/,
      :change  => /yfs_c6[34]_[^>]+>(?:<img[^>]+>)\s*([0-9,.-])+/,
      :pct_chg => /yfs_p4[34]_[^>]+>\(([0-9,.-]+)%\)/,
      :date    => /<span id="yfs_market_time">.*?, (.*?20[0-9]{1,2})/,
      :time    => /(?:"time"|"yfnc_tabledata1")><span id="yfs_t[51]0_[^>]+>(.*?)</,
      :bid     => /yfs_b00_[^>]+>([0-9,.-]{1,})/,
      :ask     => /yfs_a00_[^>]+>([0-9,.-]{1,})/,
      :open    => /Open:<\/th><td class="yfnc_tabledata1">([0-9,.-]{1,})/,
      :high    => /yfs_h53_[^>]+>([0-9,.-]{1,})/,
      :low     => /yfs_g53_[^>]+>([0-9,.-]{1,})/,
      :volume  => /yfs_v53_[^>]+>([0-9,.-]{1,})/,
      :mkt_cap => /yfs_j10_[^>]+>([0-9,.-]{1,}[KMBT]?)/)
  end
end
