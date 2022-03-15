# -*- encoding: utf-8 -*-
# stub: cucumber-tag-expressions 2.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-tag-expressions".freeze
  s.version = "2.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/cucumber/cucumber/issues", "changelog_uri" => "https://github.com/cucumber/cucumber/blob/master/tag-expressions/CHANGELOG.md", "documentation_uri" => "https://cucumber.io/docs/cucumber/api/#tag-expressions", "mailing_list_uri" => "https://groups.google.com/forum/#!forum/cukes", "source_code_uri" => "https://github.com/cucumber/cucumber/blob/master/tag-expressions/ruby" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrea Nodari".freeze, "Aslak Helles\u00F8y".freeze]
  s.date = "2020-01-10"
  s.description = "Cucumber tag expressions for ruby".freeze
  s.email = "cukes@googlegroups.com".freeze
  s.homepage = "https://cucumber.io/docs/cucumber/api/#tag-expressions".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "cucumber-tag-expressions-2.0.4".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0", ">= 13.0.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9", ">= 3.9.0"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8", ">= 0.8.23"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 13.0", ">= 13.0.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9", ">= 3.9.0"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.8", ">= 0.8.23"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 13.0", ">= 13.0.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9", ">= 3.9.0"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8", ">= 0.8.23"])
  end
end
