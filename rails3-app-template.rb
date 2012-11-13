gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'will_paginate', '~> 3.0'

group :assets do
  gem 'therubyracer', :platforms => :ruby
end

gem_group :development do
  gem "sextant", "~> 0.1.3"
  gem "quiet_assets", "~> 1.0.1"
end

run "bundle install"
run "rails g bootstrap:install"

# clean up default files
remove_file "public/index.html"
remove_file "app/assets/images/rails.png"

# exclude database configuration from source control
append_file ".gitignore", "\n/config/database.yml"

# first time setup (cold boot)
rake "db:create:all"
rake "db:migrate"
rake "db:seed"
rake "db:test:prepare"

# intialize git and commit all the things
git :init
git :add => "."
git :commit => %Q{ -am 'Initial commit' }

#authlogic stuff