source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'jquery-rails'
gem 'mongoid'
gem 'devise'
gem 'nokogiri'
gem 'emailyak', git: 'https://github.com/ballantyne/emailyak.git'
gem 'premailer', git: 'git://github.com/alexdunae/premailer.git'
gem 'state_machine'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'guard', require: nil
  gem 'guard-bundler', require: nil
  gem 'guard-rspec', require: nil
  gem 'guard-spork', require: nil
  gem 'guard-yard', require: nil
  gem 'capistrano', require: nil
  gem 'capistrano_colors', require: nil
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'awesome_print'
  gem 'quiet_assets'
  gem 'rspec-rails'
end

group :test do
  gem 'spork', require: nil
  gem 'rb-fsevent'
  gem 'database_cleaner'
  gem 'factory_girl_rails', require: nil
end

group :production do
  gem 'unicorn', require: nil
end
