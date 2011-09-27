require "rupee"
require "rupee/benchmark"
autoload :Benchmark, "benchmark"

namespace :benchmark do
  task :default => :black_scholes

  desc "Run Black-Scholes on million times"
  task :black_scholes do
    n = 1_000_000
    Benchmark.bm(11) do |x|
      x.report "rupee:" do
        n.times do
          Rupee::Options.black_scholes "c", 60, 65, 0.25, 0.08, 0, 0.3
        end
      end
      x.report("pure ruby:") do
        n.times do
          Rupee::Benchmark.black_scholes "c", 60, 65, 0.25, 0.08, 0.3
        end
      end
    end
  end
end
