source 'http://rubygems.org'

gemspec

if ENV['VCLOUD_CORE_DEV_MASTER']
  gem 'vcloud-core', :git => 'git@github.com:alphagov/vcloud-core.git', :branch => 'master'
elsif ENV['VCLOUD_CORE_DEV_LOCAL']
  gem 'vcloud-core', :path => '../vcloud-core'
end

if ENV['FOG_DEV_MASTER']
  gem 'fog', :git => 'git@github.com:fog/fog.git', :branch => 'master'
elsif ENV['FOG_DEV_LOCAL']
  gem 'fog', :path => '../fog'
end
