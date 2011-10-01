module Rupee
  module ClassFinder
    # Converts the supplied value to an instance of the specified class (if it
    # isn't already one)
    def to_instance(x, constant)
      x = x.upcase

      if x.instance_of?(constant)
        x
      else
        constant.const_get(x)
      end
    end
  end
end
