$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
require "jekyll/geocode/version"

Gem::Specification.new do |spec|
  spec.version = Jekyll::Geocode::VERSION
  spec.homepage = "https://bertrandkeller.github.io/jekyll-geocode/"
  spec.authors = ["Bertrand Keller"]
  spec.email = ["bertrand.keller@gmail.com"]
  spec.files = %W(Rakefile Gemfile README.md LICENSE) + Dir["lib/**/*"]
  spec.summary = "Geocode addresses from a YAML for drawing maps"
  spec.name = "jekyll-geocode"
  spec.license = "MIT"
  spec.has_rdoc = false
  spec.require_paths = ["lib"]
  spec.description = spec.description = <<-DESC
    Geocode addresses from a YAML for drawing maps (with https://nominatim.openstreetmap.org)
  DESC

  spec.add_runtime_dependency "jekyll", ">= 3.0", "< 4.0"

  spec.add_development_dependency "bundler", "~> 1.12"
end
