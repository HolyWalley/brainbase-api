source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.0.2", ">= 6.0.2.2"

gem "pg", ">= 0.18", "< 2.0"

gem "puma", "~> 4.3"

gem "bootsnap", ">= 1.4.2", require: false

gem "rack-cors"

gem "bcrypt"
gem "jwt_sessions", "~> 2.5", ">= 2.5.1"

gem "redis"

gem "dry-initializer", "~> 3.0"
gem "dry-monads", "~> 1.3", ">= 1.3.5"
gem "dry-rails", "~> 0.1"
gem "dry-types", "~> 1.2"

gem "fast_jsonapi", "~> 1.5"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
