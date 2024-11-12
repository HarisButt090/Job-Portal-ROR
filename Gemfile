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

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false


group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  # interface for browsing sent emails
  gem 'letter_opener_web'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
