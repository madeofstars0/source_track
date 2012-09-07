# -*- encoding: utf-8 -*-
require File.expand_path('../lib/source_track/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryan Rehbein"]
  gem.email         = ["bryan@siliconsea.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "source_track"
  gem.require_paths = ["lib"]
  gem.version       = SourceTrack::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
