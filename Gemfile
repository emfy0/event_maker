source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise'
gem 'devise-i18n'
gem 'image_processing', '>= 1.2'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'mailjet'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.2'
gem 'rails-i18n', '~> 7.0.0'
gem 'resque'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener'
  gem 'web-console'

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-nvm'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'capistrano-resque', require: false
  gem 'capistrano-rvm'
end
