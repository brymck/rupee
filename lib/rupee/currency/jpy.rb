# encoding: utf-8
module Rupee
  class Currency
    # The Japanese yen
    JPY = Currency.new "Japanese yen", :symbol => "¥", :decimal_places => 0

    # Alias for the Japanese yen
    YEN = JPY
  end
end
