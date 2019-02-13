
source "https://rubygems.org"

ruby '2.2.3'
gem "rubocop"
gem "rake"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

group :development, :test do
  gem "rspec"
  gem "simplecov", require: false
  gem "simplecov-console", require: false
end
