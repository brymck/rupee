# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rupee/version"

Gem::Specification.new do |s|
  s.name          = "rupee"
  s.version       = Rupee::VERSION
  s.authors       = ["Bryan McKelvey"]
  s.email         = ["bryan.mckelvey@gmail.com"]
  s.homepage      = "https://github.com/brymck/rupee"
  s.summary       = "Financial tools for Ruby"
  s.description   = <<-eos
                      rupee aims to provide user-friendly tools for use in
                      financial gems and applications.
                    eos

  s.rubyforge_project = "rupee"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/**/*_spec.rb`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
    File.basename(f)
  end
  s.extensions    = "ext/rupee/extconf.rb"
  s.require_paths = ["lib", "ext"]

  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "rspec",   "~> 2.0"
  s.add_development_dependency "sdoc",    "~> 0.3"
  s.add_development_dependency "autotest"
  s.add_development_dependency "autotest-fsevent"
  s.add_development_dependency "autotest-growl"
end
