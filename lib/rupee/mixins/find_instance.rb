module Rupee
  # For finding instances within a class
  module FindInstance
    # Converts the supplied value to an instance of the specified class (if it
    # isn't already one). For example, within the Source object you could find
    # the Bloomberg object one of two ways:
    #
    #   Rupee::Source.find :bloomberg
    #   Rupee::Source.find Rupee::Source::BLOOMBERG
    #
    # This allows the user more flexibility, as specifying the full path to
    # the <tt>BLOOMBERG</tt> constant is no longer necessary
    def find(x)
      if x.instance_of?(self)
        # If x is an actual instance of the class, just return it
        x
      else
        # Otherwise, search for constants after capitalizing x
        self.const_get x.upcase
      end
    end
  end
end
