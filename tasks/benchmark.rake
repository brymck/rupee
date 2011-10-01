autoload :Benchmark, "benchmark"

desc "Run some tests comparing native C implementations vs pure Ruby"
task :benchmark do

  n = 100_000
  n_str = n.to_s.gsub /(\d)(?=(\d\d\d)+(?!\d))/, "\\1,"
  offset = 19

  puts "\nTime to load all classes and defaults"

  Benchmark.bm(offset) do |x|
    x.report "Basic:" do
      require "rupee"
    end

    x.report "All:" do
      Rupee.constants.each do |c|
        const = Rupee.const_get(c)

        if const.respond_to?(:constants)
          const.constants.each do |sc|
            const.const_get sc
          end
        end
      end
    end
  end

  puts "\nBlack-Scholes (#{n_str} times)"

  Benchmark.bm(offset) do |x|
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

    puts
  end
end
