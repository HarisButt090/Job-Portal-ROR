source "https://rubygems.org"

gem "rails", "~> 7.2.1", ">= 7.2.1.2"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
# for authentication purposes
gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'devise-jwt'
gem 'devise_invitable'
gem 'pry'
gem "tzinfo-data", platforms: %i[ jruby ]

gem "bootsnap", require: false

gem "graphql"

group :development, :test do
  gem "debug", platforms: %i[ mri ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  # interface for browsing sent emails
  gem 'letter_opener_web'

  # interface to tets GraphQl API
  gem "graphiql-rails"
  gem "faker"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
