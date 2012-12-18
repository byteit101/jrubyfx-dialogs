# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'RubyFXDialogs/version'

Gem::Specification.new do |gem|
  gem.name          = "rubyfx-dialogs"
  gem.version       = RubyFXDialogs::VERSION
  gem.authors       = ["Patrick Plenefisch"]
  gem.email         = ["simonpatp@gmail.com"]
  gem.description   = "Useful JavaFX dialogs for ruby"
  gem.summary       = "Useful JavaFX dialogs for ruby"
  gem.homepage      = ""
  
  gem.add_dependency "jrubyfxml"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
