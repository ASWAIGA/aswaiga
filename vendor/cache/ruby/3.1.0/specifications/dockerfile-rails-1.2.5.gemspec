# -*- encoding: utf-8 -*-
# stub: dockerfile-rails 1.2.5 ruby lib

Gem::Specification.new do |s|
  s.name = "dockerfile-rails".freeze
  s.version = "1.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "https://github.com/rubys/dockerfile-rails" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sam Ruby".freeze]
  s.date = "2023-03-05"
  s.email = "rubys@intertwingly.net".freeze
  s.homepage = "https://github.com/rubys/dockerfile-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.12".freeze
  s.summary = "Dockerfile generator for Rails".freeze

  s.installed_by_version = "3.4.12" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<rails>.freeze, [">= 0"])
end
