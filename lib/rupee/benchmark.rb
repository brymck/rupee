module Rupee
  # Just for use in benchmarking the performance of Rupee code
  class Benchmark
    class << self
      # Black-Scholes option price valuation
      # by Michael Neumann (with some revisions)
      # http://www.espenhaug.com/black_scholes.html
      def black_scholes(callPutFlag, s, x, t, r, v)
        d1 = (Math.log(s / x) + (r + v * v / 2.0) * t) / (v * Math.sqrt(t))
        d2 = d1 - v * Math.sqrt(t)
        if callPutFlag == 'c'
          s * cnd(d1) - x * Math.exp(-r * t) * cnd(d2)
        else
          x * Math.exp(-r * t) * cnd(-d2) - s * cnd(-d1)
        end
      end

      private

      A1 =  0.31938153
      A2 = -0.356563782
      A3 =  1.781477937
      A4 = -1.821255978
      A5 =  1.330274429

      # Cumulative normal distribution
      # by Michael Neumann (with some revisions)
      # http://www.espenhaug.com/black_scholes.html
      def cnd(x)
        l = x.abs
        k = 1.0 / (1.0 + 0.2316419 * l)
        w = 1.0 - 1.0 / Math.sqrt(2 * Math::PI) * Math.exp(-l * l / 2.0) *
          (A1 * k + A2 * k * k + A3 * (k ** 3) + A4 * (k ** 4) + A5 * (k ** 5))
        w = 1.0 - w if x < 0
        return w
      end
    end
  end
end
