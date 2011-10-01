module Rupee
  class Source
    YAHOO = Source.new(:yahoo,
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
  end
end
