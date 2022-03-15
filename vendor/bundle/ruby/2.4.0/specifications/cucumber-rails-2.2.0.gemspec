# -*- encoding: utf-8 -*-
# stub: cucumber-rails 2.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-rails".freeze
  s.version = "2.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/cucumber/cucumber-rails/issues", "changelog_uri" => "https://github.com/cucumber/cucumber-rails/blob/v2.2.0/CHANGELOG.md", "documentation_uri" => "https://cucumber.io/docs", "mailing_list_uri" => "https://groups.google.com/forum/#!forum/cukes", "source_code_uri" => "https://github.com/cucumber/cucumber-rails/tree/v2.2.0" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aslak Helles\u00F8y".freeze, "Dennis Bl\u00F6te".freeze, "Rob Holland".freeze]
  s.date = "2020-10-08"
  s.description = "Cucumber Generator and Runtime for Rails".freeze
  s.email = "cukes@googlegroups.com".freeze
  s.homepage = "https://cucumber.io".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "cucumber-rails-2.2.0".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capybara>.freeze, [">= 2.18", "< 4"])
      s.add_runtime_dependency(%q<cucumber>.freeze, [">= 3.0.2", "< 6"])
      s.add_runtime_dependency(%q<mime-types>.freeze, ["~> 3.2"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 5.0", "< 7"])
      s.add_development_dependency(%q<ammeter>.freeze, [">= 1.1.4"])
      s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.2"])
      s.add_development_dependency(%q<aruba>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.17"])
      s.add_development_dependency(%q<rake>.freeze, [">= 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.89.0"])
      s.add_development_dependency(%q<rubocop-packaging>.freeze, ["~> 0.3.0"])
      s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.7.1"])
      s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 1.42.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 6.0"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.10"])
    else
      s.add_dependency(%q<capybara>.freeze, [">= 2.18", "< 4"])
      s.add_dependency(%q<cucumber>.freeze, [">= 3.0.2", "< 6"])
      s.add_dependency(%q<mime-types>.freeze, ["~> 3.2"])
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
      s.add_dependency(%q<rails>.freeze, [">= 5.0", "< 7"])
      s.add_dependency(%q<ammeter>.freeze, [">= 1.1.4"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 2.2"])
      s.add_dependency(%q<aruba>.freeze, ["~> 1.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.17"])
      s.add_dependency(%q<rake>.freeze, [">= 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.89.0"])
      s.add_dependency(%q<rubocop-packaging>.freeze, ["~> 0.3.0"])
      s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.7.1"])
      s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.42.0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rdoc>.freeze, [">= 6.0"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9.10"])
    end
  else
    s.add_dependency(%q<capybara>.freeze, [">= 2.18", "< 4"])
    s.add_dependency(%q<cucumber>.freeze, [">= 3.0.2", "< 6"])
    s.add_dependency(%q<mime-types>.freeze, ["~> 3.2"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
    s.add_dependency(%q<rails>.freeze, [">= 5.0", "< 7"])
    s.add_dependency(%q<ammeter>.freeze, [">= 1.1.4"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.2"])
    s.add_dependency(%q<aruba>.freeze, ["~> 1.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.17"])
    s.add_dependency(%q<rake>.freeze, [">= 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.89.0"])
    s.add_dependency(%q<rubocop-packaging>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.7.1"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.42.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rdoc>.freeze, [">= 6.0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.10"])
  end
end
