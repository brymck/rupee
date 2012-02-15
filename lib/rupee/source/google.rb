module Rupee
  class Source
    # Google Finance
    GOOGLE = Source.new(:google,
      "http://www.google.com/ig/api?stock=%s",
      :price   => /<last data="([0-9.-]*)"/,
      :change  => /<change data="\+?([0-9.-]*)"/,
      :pct_chg => /<perc_change data="([0-9.-]*)"/,
      :date    => /<trade_date_utc data="([0-9.-]*)"/,
      :time    => /<trade_date_utc data="([0-9.-]*)"/,
      :open    => /<open data="([0-9.-]*)"/,
      :high    => /<high data="([0-9.-]*)"/,
      :low     => /<low data="([0-9.-]*)"/,
      :volume  => /<volume data="([0-9.-]*)"/,
      :mkt_cap => /<market_cap data="([0-9.-]*)"/)
  end
end
