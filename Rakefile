require 'rspec/core/rake_task'
require 'gem_publisher'

task :default => [:rubocop]

task :publish_gem do
  gem = GemPublisher.publish_if_updated("vcloud-disk_launcher.gemspec", :rubygems)
  puts "Published #{gem}" if gem
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--lint']
end
