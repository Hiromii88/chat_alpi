# -*- encoding: utf-8 -*-
# stub: sorbet-runtime 0.5.12224 ruby lib

Gem::Specification.new do |s|
  s.name = "sorbet-runtime".freeze
  s.version = "0.5.12224"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "source_code_uri" => "https://github.com/sorbet/sorbet" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stripe".freeze]
  s.date = "2025-07-15"
  s.description = "Sorbet's runtime type checking component".freeze
  s.homepage = "https://sorbet.org".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Sorbet runtime".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.11"])
    s.add_development_dependency(%q<mocha>.freeze, ["~> 2.1"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 1.57.1"])
    s.add_development_dependency(%q<rubocop-performance>.freeze, ["= 1.13.2"])
    s.add_development_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
    s.add_development_dependency(%q<debug>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
    s.add_development_dependency(%q<subprocess>.freeze, ["~> 1.5.3"])
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.11"])
    s.add_dependency(%q<mocha>.freeze, ["~> 2.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 1.57.1"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["= 1.13.2"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
    s.add_dependency(%q<debug>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
    s.add_dependency(%q<subprocess>.freeze, ["~> 1.5.3"])
  end
end
