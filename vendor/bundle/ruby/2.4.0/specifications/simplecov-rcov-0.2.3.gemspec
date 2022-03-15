# -*- encoding: utf-8 -*-
# stub: simplecov-rcov 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "simplecov-rcov".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fernando Guillen http://fernandoguillen.info".freeze, "Wes Morgan http://github.com/cap10morgan".freeze, "Wandenberg Peixoto http://github.com/wandenberg".freeze]
  s.date = "2011-02-09"
  s.description = "Rcov style formatter for SimpleCov".freeze
  s.email = ["fguillen.mail@gmail.com".freeze, "cap10morgan@gmail.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "lib/simplecov-rcov.rb".freeze]
  s.files = ["README.md".freeze, "lib/simplecov-rcov.rb".freeze]
  s.homepage = "http://github.com/fguillen/simplecov-rcov".freeze
  s.rdoc_options = ["--line-numbers".freeze, "--inline-source".freeze, "--title".freeze, "Simplecov-rcov".freeze, "--main".freeze, "README.md".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Rcov style formatter for SimpleCov".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<simplecov>.freeze, [">= 0.4.1"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0.0.rc.6"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<simplecov>.freeze, [">= 0.4.1"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0.0.rc.6"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<simplecov>.freeze, [">= 0.4.1"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0.0.rc.6"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
