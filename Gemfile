source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree', github: 'spree/spree', branch: 'master'
gem 'rails-controller-testing'
gem 'rubocop-rails', '~> 2.12', '>= 2.12.4'

gemspec
