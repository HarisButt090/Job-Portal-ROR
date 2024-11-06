# -*- encoding: utf-8 -*-
# stub: letter_opener_web 1.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "letter_opener_web".freeze
  s.version = "1.1.3".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fabio Rehm".freeze]
  s.date = "2014-02-21"
  s.description = "Gives letter_opener an interface for browsing sent emails".freeze
  s.email = ["fgrehm@gmail.com".freeze]
  s.homepage = "https://github.com/fgrehm/letter_opener_web".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.1.5".freeze
  s.summary = "Gives letter_opener an interface for browsing sent emails".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<rails>.freeze, [">= 3.2".freeze])
  s.add_runtime_dependency(%q<letter_opener>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 2.0".freeze])
  s.add_development_dependency(%q<shoulda-matchers>.freeze, ["= 1.5.6".freeze])
  s.add_development_dependency(%q<combustion>.freeze, ["~> 0.3.1".freeze])
end
