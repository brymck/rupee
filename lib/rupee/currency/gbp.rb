# encoding: utf-8
module Rupee
  class Currency
    # The British pound sterling
    GBP = Currency.new "British pound sterling", :symbol => "£"

    # Alias for the British pound
    Pound = GBP
  end
end
