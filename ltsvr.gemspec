# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ltsvr/version'

Gem::Specification.new do |gem|
  gem.name          = "ltsvr"
  gem.version       = Ltsvr::VERSION
  gem.authors       = ["ongaeshi"]
  gem.email         = ["ongaeshi0621@gmail.com"]
  gem.description   = %q{LTSV viewer for Ruby. Select label, Filtering keyword, Go to LTSV website.}
  gem.summary       = %q{LTSV viewer for Ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'ltsv'
  gem.add_dependency 'launchy'
end
