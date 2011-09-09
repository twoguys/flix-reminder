# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "flixy/version"

Gem::Specification.new do |s|
  s.name        = "flixy"
  s.version     = Flixy::VERSION
  s.authors     = ["Marshall Huss"]
  s.email       = ["mwhuss@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Netflix API Wrapper}
  s.description = %q{Netflix API Wrapper}

  s.rubyforge_project = "flixy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "multi_xml"
  s.add_runtime_dependency "hashie"
  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "faraday_middleware" 
  s.add_runtime_dependency "simple_oauth" 
end
