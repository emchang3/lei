Gem::Specification.new do |spec|
  spec.name          = "lei"
  spec.version       = "0.2.9"
  spec.authors       = ["Ezra Chang"]
  spec.email         = ["ezra.mintao.chang@gmail.com"]

  spec.summary       = "A springboard for AMP-ready static sites"
  spec.description   = <<~DESC
    This framework glues together Sinatra, Markdown, and LESS to create
    AMP sites, ready for launch.
  DESC
  spec.homepage      = "https://github.com/emchang3/lei"
  spec.license       = "MIT"

  spec.files         = Dir["bin/**/*.rb", "example/**/*.rb"]
  spec.executables   = ["lei"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "node.js", ">= 9.0.0"
end
