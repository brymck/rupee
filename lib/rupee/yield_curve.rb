module Rupee
  class YieldCurve
    include FindInstance

    def initialize(description = "", opts = {})
      opts = {
        :currency      => :usd,
        :interpolation => :cubic_spline
      }.merge opts

      @description = description
    end
  end
end
