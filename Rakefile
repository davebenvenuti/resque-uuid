require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "resque-uuid"
    gem.summary = "Generates a UUID for Resque jobs as they are enqueued"
    gem.email = "davebenvenuti@gmail.com"
    gem.homepage = "http://github.com/davebenvenuti/resque-uuid"
    gem.authors = ["davebenvenuti"]
    gem.add_dependency "resque", "1.13.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
