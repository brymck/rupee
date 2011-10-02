module Rupee
  # For finding instances within a class
  module FindInstance
    # Converts the supplied value to an instance of the specified class (if it
    # isn't already one)
    def find(x)
      if x.instance_of?(self)
        x
      else
        self.const_get x.upcase
      end
    end
  end
end
