autoload :Benchmark, "benchmark"

desc "Run some tests comparing native C implementations vs pure Ruby"
task :benchmark do
  require "rupee"
  require "rupee/benchmark"

  n = 100_000

  puts "Black-Scholes (#{n.to_s.gsub /(\d)(?=(\d\d\d)+(?!\d))/, "\\1,"} times)"

  Benchmark.bm(19) do |x|
    x.report "Rupee (class):" do
      n.times do
        Rupee::Option.black_scholes "c", 60, 65, 0.25, 0.08, 0, 0.3
      end
    end

    x.report "Rupee (one object):" do
      call = Rupee::Call.new(
        :underlying => 60,
        :strike     => 65,
        :time       =>  0.25,
        :rate       =>  0.08,
        :div_yield  =>  0.00,
        :volatility =>  0.3
      )

      n.times do
        call.black_scholes
      end
    end

    x.report "Rupee (new object):" do
      n.times do
        Rupee::Call.new(
         :underlying => 60,
         :strike     => 65,
         :time       =>  0.25,
         :rate       =>  0.08,
         :div_yield  =>  0.00,
         :volatility =>  0.3
       ).black_scholes
      end
    end

    x.report("Pure Ruby:") do
      n.times do
        Rupee::Benchmark.black_scholes "c", 60, 65, 0.25, 0.08, 0.3
      end
    end
  end
end
