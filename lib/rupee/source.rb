require "rupee/mixins/find_instance"

module Rupee
  # A class to hold quote sources
  class Source
    # Autoload default sources
    autoload :BLOOMBERG, "rupee/source/bloomberg"
    autoload :GOOGLE,    "rupee/source/google"
    autoload :YAHOO,     "rupee/source/yahoo"

    # The name of the source
    attr :name
    # The full URL for where the security information is located, where
    # <tt>%s</tt> is a query parameter
    attr :url
    # The parameters available
    attr :params

    # Creates a new quote service
    def initialize(name, url, params = {})
      @name, @url, @params = name, url, params
    end

    class << self
      include FindInstance
    end
  end
end
