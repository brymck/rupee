module Rupee
  # Just for use in benchmarking the performance of Rupee code
  class Benchmark
    class << self
      # Black-Scholes option price valuation
      #
      # by Michael Neumann (with some revisions)
      #
      # http://www.espenhaug.com/black_scholes.html
      def black_scholes(call_put_flag, s, x, t, r, v)
        d1 = (Math.log(s / x) + (r + v * v / 2.0) * t) / (v * Math.sqrt(t))
        d2 = d1 - v * Math.sqrt(t)
        if call_put_flag == 'c'
          s * cnd(d1) - x * Math.exp(-r * t) * cnd(d2)
        else
          x * Math.exp(-r * t) * cnd(-d2) - s * cnd(-d1)
        end
      end

      private

      # Cumulative normal distribution
      #
      # by Michael Neumann (with some revisions)
      #
      # http://www.espenhaug.com/black_scholes.html
      def cnd(x)
        l = x.abs
        k = 1.0 / (1.0 + 0.2316419 * l)
        w = 1.0 - 1.0 / Math.sqrt(2 * Math::PI) * Math.exp(-l * l / 2.0) *
          ( 0.31938153  *  k +
           -0.356563782 * (k ** 2) +
            1.781477937 * (k ** 3) +
           -1.821255978 * (k ** 4) +
            1.330274429 * (k ** 5))
        w = 1.0 - w if x < 0
      end
    end
  end
end
