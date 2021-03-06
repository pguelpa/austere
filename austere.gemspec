# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "austere/version"

Gem::Specification.new do |s|
  s.name        = "austere"
  s.version     = Austere::VERSION
  s.authors     = ["Paul Guelpa"]
  s.email       = ["paul.guelpa@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A Gem for defining your API}
  s.description = %q{define define define}

  s.rubyforge_project = "austere"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "spork"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-debugger"

  # s.add_runtime_dependency "rest-client"
end
