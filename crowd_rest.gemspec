# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "crowd_rest/version"

Gem::Specification.new do |s|
  s.name        = "crowd_rest"
  s.version     = CrowdRest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Blake"]
  s.email       = ["justin@hentzia.com"]
  s.homepage    = "https://github.com/blaix/crowd-rest"
  s.summary     = %q{Ruby client for Atlassian's Crowd REST API}
  s.description = %q{Ruby client for Atlassian's Crowd REST API. Word up.}

  s.rubyforge_project = "crowd_rest"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  #s.add_dependency 'httpary'

  #s.add_development_dependency 'rspec'
end
