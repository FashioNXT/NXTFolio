# -*- encoding: utf-8 -*-
# stub: cucumber-cucumber-expressions 10.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-cucumber-expressions".freeze
  s.version = "10.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/cucumber/cucumber/issues", "changelog_uri" => "https://github.com/cucumber/cucumber/blob/master/cucumber-expressions/CHANGELOG.md", "documentation_uri" => "https://cucumber.io/docs/cucumber/cucumber-expressions/", "mailing_list_uri" => "https://groups.google.com/forum/#!forum/cukes", "source_code_uri" => "https://github.com/cucumber/cucumber/blob/master/cucumber-expressions/ruby" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aslak Helles\u00F8y".freeze]
  s.date = "2020-08-07"
  s.description = "Cucumber Expressions - a simpler alternative to Regular Expressions".freeze
  s.email = "cukes@googlegroups.com".freeze
  s.homepage = "https://github.com/cucumber/cucumber-expressions-ruby#readme".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "cucumber-expressions-10.3.0".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0", ">= 13.0.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9", ">= 3.9.0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 13.0", ">= 13.0.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9", ">= 3.9.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 13.0", ">= 13.0.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9", ">= 3.9.0"])
  end
end
