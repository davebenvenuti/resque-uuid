# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "resque-uuid"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["davebenvenuti"]
  s.date = "2012-06-19"
  s.email = "davebenvenuti@gmail.com"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/resque-uuid.rb",
    "lib/resque/plugins/resque_uuid.rb",
    "lib/resque/plugins/resque_uuid/job_extensions.rb",
    "lib/resque/plugins/resque_uuid/resque_extensions.rb",
    "lib/resque/plugins/resque_uuid/util.rb",
    "resque-uuid.gemspec",
    "test/redis-test.conf",
    "test/resque/plugins/resque_uuid/job_extensions_test.rb",
    "test/resque/plugins/resque_uuid/resque_extensions_test.rb",
    "test/resque/plugins/resque_uuid/util_test.rb",
    "test/resque/plugins/resque_uuid_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = "http://github.com/davebenvenuti/resque-uuid"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Generates a UUID for Resque jobs as they are enqueued"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<resque>, [">= 0"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 0"])
      s.add_runtime_dependency(%q<resque>, ["= 1.13.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<resque>, [">= 0"])
      s.add_dependency(%q<uuidtools>, [">= 0"])
      s.add_dependency(%q<resque>, ["= 1.13.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<resque>, [">= 0"])
    s.add_dependency(%q<uuidtools>, [">= 0"])
    s.add_dependency(%q<resque>, ["= 1.13.0"])
  end
end

