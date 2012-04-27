source 'http://rubygems.org'

gem 'rails', '3.2.3'
gem 'gravatar_image_tag', '1.1.2'
gem 'will_paginate', '3.0.3'

group :test do
  gem 'rspec', '2.9.0'
  gem 'webrat', '0.7.3'
  gem 'spork'
  gem 'factory_girl_rails', '3.2.0'
end

group :development, :test do
  gem 'faker', '1.0.1'
  gem 'rspec-rails'
  gem 'heroku'
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'

  gem 'spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'growl'
end

group :production, :staging do
  gem 'pg'
  gem 'thin'
end