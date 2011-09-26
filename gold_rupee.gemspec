# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gold_rupee/version"

Gem::Specification.new do |s|
  s.name        = "gold_rupee"
  s.version     = GoldRupee::VERSION
  s.authors     = ["Bryan McKelvey"]
  s.email       = ["bryan.mckelvey@gmail.com"]
  s.homepage    = "http://www.brymck.com"
  s.summary     = %q{Financial tools for Ruby}
  s.description = %q{gold_rupee aims to provide user-friendly tools for use in financial applications.}

  s.rubyforge_project = "gold_rupee"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
