# -*- encoding: utf-8 -*-
require File.expand_path('../lib/source_track/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryan Rehbein"]
  gem.email         = ["bryan@siliconsea.net"]
  gem.description   = %q{Gem to help understand a user's interaction with your site 
                         and the influence of various referrals, promos, campaigns, etc.}
  gem.summary       = %q{Track the influence that your marketing campaigns and referrals 
                         have on your users.}
  gem.homepage      = "https://github.com/redbeard0x0a/source_track"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "source_track"
  gem.require_paths = ["lib"]
  gem.version       = SourceTrack::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
