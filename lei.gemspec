Gem::Specification.new do |spec|
  spec.name          = "lei"
  spec.version       = "0.1.0"
  spec.authors       = ["Ezra Chang"]
  spec.email         = ["ezra.mintao.chang@gmail.com"]

  spec.summary       = "A springboard for AMP-ready static sites"
  spec.description   = <<~DESC
    This framework glues together Sinatra, Markdown, and LESS to create
    AMP-ready sites, ready for launch.
  DESC
  spec.homepage      = "https://jnsq.ninja"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = Dir["bin/**/*.rb", "example/**/*.rb"]
  spec.executables   = ["lei"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
