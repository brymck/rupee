require "rupee/rupee" # keep this as the first require
require "rupee/version"
require "date"

# Rupee aims to provide user-friendly tools for use in financial applications.
# The gem is in its development stages, but it currently offers:
#
# * Live, streaming web import capabilities (Excel 2002+), including custom
# functions for easily importing security prices from Bloomberg.com, Google
# Finance and Yahoo! Finance
# * Basic options pricing, including Black-Scholes, the options Greeks and a
# few more complex options models
# 
# Author::    Bryan McKelvey (mailto:bryan.mckelvey@gmail.com)
# Copyright:: Copyright (c) 2011 Bryan McKelvey
# License::   MIT

# This module contains all modules and classes associated with Rupee
module Rupee
  autoload :Security,    "rupee/security"

  autoload :Benchmark,   "rupee/benchmark"
  autoload :BusinessDay, "rupee/business_day"
  autoload :Calendar,    "rupee/calendar"
  autoload :Call,        "rupee/option"
  autoload :Curve,       "rupee/curve"
  autoload :FixedIncome, "rupee/fixed_income"
  autoload :Currency,    "rupee/currency"
  autoload :DayCount,    "rupee/day_count"
  autoload :Frequency,   "rupee/frequency"
  autoload :Option,      "rupee/option"
  autoload :Put,         "rupee/option"
  autoload :Quote,       "rupee/quote"
  autoload :Rate,        "rupee/rate"
  autoload :Source,      "rupee/source"
end
