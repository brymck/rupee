require "rupee/rupee" # keep this as the first require
require "rupee/version"
require "rupee/security"
require "rupee/option.rb"

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
  # autoload :Option, "rupee/option.rb"
  autoload :Calendar, "rupee/calendar"
  autoload :Quote, "rupee/quote"
end
