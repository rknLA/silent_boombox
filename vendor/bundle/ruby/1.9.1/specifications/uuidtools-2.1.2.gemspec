# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "uuidtools"
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Aman"]
  s.date = "2011-02-02"
  s.description = "A simple universally unique ID generation library.\n"
  s.email = "bob@sporkmonger.com"
  s.extra_rdoc_files = ["README"]
  s.files = ["README"]
  s.homepage = "http://uuidtools.rubyforge.org/"
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "uuidtools"
  s.rubygems_version = "1.8.10"
  s.summary = "UUID generator"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0.8.3"])
      s.add_development_dependency(%q<rspec>, [">= 1.1.11"])
      s.add_development_dependency(%q<launchy>, [">= 0.3.2"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.3"])
      s.add_dependency(%q<rspec>, [">= 1.1.11"])
      s.add_dependency(%q<launchy>, [">= 0.3.2"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.3"])
    s.add_dependency(%q<rspec>, [">= 1.1.11"])
    s.add_dependency(%q<launchy>, [">= 0.3.2"])
  end
end
