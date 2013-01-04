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
  
  gem.add_dependency "jrubyfx"

  gem.files         = Dir.glob("lib/**/*") + %w(LICENSE.txt README.md)
  gem.executables   = []
  gem.test_files    = []
  gem.require_paths = ["lib"]
end
