
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lei/version"

Gem::Specification.new do |spec|
  spec.name          = "lei"
  spec.version       = Lei::VERSION
  spec.authors       = ["Ezra Chang"]
  spec.email         = ["ezra.mintao.chang@gmail.com"]

  spec.summary       = "A Sinatra-based springboard for AMP projects."
  spec.homepage      = "https://github.com/emchang3/lei"
  spec.license       = "MIT"

  spec.files         = [ "bin/*", "lib/*", "spec/*" ]
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
