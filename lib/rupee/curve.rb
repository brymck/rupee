module Rupee
  # A class representing a yield or basis curve
  class Curve
    include FindInstance

    autoload :LIBOR_3M, "rupee/curve/libor_3m"

    # The curve's currency
    attr :currency
    # A description for the curve
    attr :description
    # The interpolation method
    attr :interpolation

    # Create a new curve
    def initialize(description = "", opts = {})
      opts = {
        :currency      => :usd,
        :interpolation => :cubic_spline
      }.merge opts

      @description   = description
      @currency      = opts[:currency]
      @interpolation = opts[:interpolation]
    end
  end
end
