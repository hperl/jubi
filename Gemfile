source 'https://rubygems.org'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'rails', '~> 4.2'

# Rails' PJAX
gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'pg'

# static pages
gem 'high_voltage'

# authentication
gem 'devise'
# authorization
gem 'cancancan', '~> 1.10'

# settings
gem 'config', '~> 1.0.0.beta3'

gem 'redcarpet'

gem 'spreadsheet'
gem 'state_machine'

gem 'groupdate'
gem 'chartkick'
gem 'highcharts-rails', '~> 3.0.0'
gem 'numbers_and_words'
gem 'rails_autolink'

gem 'http_accept_language'

gem 'exception_notification'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'unicorn'

group :development do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.2'
  gem 'capistrano-rails', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-bundler', require: false
  gem 'sqlite3'
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', require: false
  gem 'rspec-activemodel-mocks'
end

# assets
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'haml'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'less-rails'
gem 'foundation-rails', '5.4.5'
gem 'font-awesome-rails'
gem 'simple_form'
gem 'navigasmic'
gem 'leaflet-rails'
gem 'ckeditor'
