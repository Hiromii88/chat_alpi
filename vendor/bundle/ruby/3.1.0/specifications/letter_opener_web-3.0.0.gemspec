# -*- encoding: utf-8 -*-
# stub: letter_opener_web 3.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "letter_opener_web".freeze
  s.version = "3.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fabio Rehm".freeze, "David Muto".freeze]
  s.date = "2024-05-14"
  s.description = "Gives letter_opener an interface for browsing sent emails".freeze
  s.email = ["fgrehm@gmail.com".freeze, "david.muto@gmail.com".freeze]
  s.homepage = "https://github.com/fgrehm/letter_opener_web".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Gives letter_opener an interface for browsing sent emails".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<actionmailer>.freeze, [">= 6.1"])
    s.add_runtime_dependency(%q<letter_opener>.freeze, ["~> 1.9"])
    s.add_runtime_dependency(%q<railties>.freeze, [">= 6.1"])
    s.add_runtime_dependency(%q<rexml>.freeze, [">= 0"])
  else
    s.add_dependency(%q<actionmailer>.freeze, [">= 6.1"])
    s.add_dependency(%q<letter_opener>.freeze, ["~> 1.9"])
    s.add_dependency(%q<railties>.freeze, [">= 6.1"])
    s.add_dependency(%q<rexml>.freeze, [">= 0"])
  end
end
