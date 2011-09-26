# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rupee/version"

Gem::Specification.new do |s|
  s.name              = "rupee"
  s.version           = Rupee::VERSION
  s.authors           = ["Bryan McKelvey"]
  s.email             = ["bryan.mckelvey@gmail.com"]
  s.homepage          = "http://brymck.herokuapp.com"
  s.summary           = "Financial tools for Ruby"
  s.description       = "rupee aims to provide user-friendly tools for use in financial gems and applications."

  s.rubyforge_project = "rupee"

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extensions        = "ext/rupee/extconf.rb"
  s.require_paths     = ["lib", "ext"]

  # specify any dependencies here; for example:
  s.add_development_dependency "bundler",  "~> 1.0"
  s.add_development_dependency "rspec",    "~> 2.0"
  s.add_development_dependency "autotest", "~> 4.0"
  # s.add_runtime_dependency "rest-client"
end
